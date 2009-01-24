package com.pnwrain.pictair_me.business
{
	import com.pnwrain.pictair_me.vo.Picture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.graphics.codec.JPEGEncoder;
	
	public class PictureManager
	{
		private const picturePath:File = File.applicationStorageDirectory.resolvePath("pictures");
		[Bindable]
		public var pictures:ArrayCollection = new ArrayCollection();
		
		public function PictureManager()
		{
			if ( !picturePath.exists ) {
				picturePath.createDirectory();
			}
			pictures = new ArrayCollection( );
			var pa:Array = picturePath.getDirectoryListing();
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
			
			var image:File = picturePath.resolvePath(new Date().time + ".jpg");
			var fs:FileStream = new FileStream();
			fs.open(image,FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
			trace(image.nativePath);
			
			pictures.addItem( new Picture(image as File) );
			
		}
		private function copyBitmap(source:DisplayObject):BitmapData {
			var bmd:BitmapData = new BitmapData(source.width, source.height);
			bmd.draw(source);
			return bmd
		}
		

	}
}