package com.pnwrain.pictair_me.business
{
	import com.pnwrain.pictair_me.vo.Picture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.graphics.codec.JPEGEncoder;
	import mx.utils.Base64Encoder;
	
	public class PictureManager
	{
		private const pictureDirectory:File = File.applicationStorageDirectory.resolvePath("pictures");
		[Bindable]
		public var pictures:ArrayCollection = new ArrayCollection();
		
		public function PictureManager()
		{
			if ( !pictureDirectory.exists ) {
				pictureDirectory.createDirectory();
			}
			pictures = new ArrayCollection( );
			var pa:Array = pictureDirectory.getDirectoryListing();
			for ( var i:int=0;i<pa.length;i++ ) {
				if ( File(pa[i]).extension == "jpg" ) {
					pictures.addItem( new Picture(pa[i] as File) );
				}
			}
			trace("pictures saved: " + pictures.length);
		}
		public function loadPictures():Array {
			var pic_path:Array = [];
			for ( var i:int=0;i<pictures.length;i++) {
				pic_path.push(pictures.getItemAt(i).url );
			}
			
			return pic_path;
		}
		public function savePicture(source:DisplayObject):void {
			var jpe:JPEGEncoder = new JPEGEncoder(100);
			var imageBitmap:Bitmap = new Bitmap( copyBitmap(source) );
			
			//flip horizontal matrix
			var flipHorizontalMatrix:Matrix = new Matrix()
			flipHorizontalMatrix.scale(-1,1)
			flipHorizontalMatrix.translate(imageBitmap.width,0)
			
			var flippedBitmap:BitmapData = new BitmapData(imageBitmap.width,imageBitmap.height,false,0xFFCC00)
			flippedBitmap.draw(imageBitmap,flipHorizontalMatrix)

			var data:ByteArray = jpe.encode( flippedBitmap );
			
			var image:File = pictureDirectory.resolvePath(new Date().time + ".jpg");
			var fs:FileStream = new FileStream();
			fs.open(image,FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
			trace(image.nativePath);
			
			pictures.addItem( new Picture(image as File) );
			
		}
		public function upload(picture:Picture):void {
			var file:File = new File(picture.url);
			if ( file ) {
				twitterUpload(file);
				//uploadMyFile(file);
			}
		}
		private function copyBitmap(source:DisplayObject):BitmapData {
			var bmd:BitmapData = new BitmapData(source.width, source.height);
			bmd.draw(source);
			return bmd
		}
		private function onFault(event:Event):void {
			
		}
		private function onProgress(event:ProgressEvent):void {
			trace('Image uploading: %' + event.bytesLoaded*100/event.bytesTotal)
		}
		private function onComplete(event:Event):void {
			trace('Image Uploaded');
		}
		
		private function twitterUpload(file:File):void {
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			var jpegDataByteArray:ByteArray = new ByteArray();
			fs.readBytes(jpegDataByteArray);
			
			var multi:MultipartRequest = new MultipartRequest();
			multi.file = jpegDataByteArray;
			multi.filename = file.name;
			 
			var postdata:ByteArray = multi.getPostData();
			 
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.POST;
			req.contentType = "multipart/form-data; boundary=" + multi.getBoundary();
			req.data = postdata;
			req.url = "http://twitter.com/account/update_profile_image.xml";
			//var base64:Base64Encoder = new Base64Encoder();
			//base64.encode ("username" + ":" + "password");
			//req.requestHeaders.push(new URLRequestHeader ("Authorization", "Basic " + base64.toString()));
			
			var ldr:URLLoader = new URLLoader();
			ldr.addEventListener(IOErrorEvent.IO_ERROR, onFault);
			ldr.addEventListener(ProgressEvent.PROGRESS, onProgress);
			ldr.addEventListener(Event.COMPLETE, onComplete);
			ldr.load(req);
			 
		}
		
	}
}