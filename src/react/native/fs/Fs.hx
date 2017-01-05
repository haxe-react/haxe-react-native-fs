package react.native.fs;

import js.Promise;

@:jsRequire('react-native-fs')
extern class Fs {
	static var MainBundlePath:String;
	static var CachesDirectoryPath:String;
	static var DocumentDirectoryPath:String;
	static var TemporaryDirectoryPath:String;
	static var ExternalDirectoryPath:String;
	static var ExternalStorageDirectoryPath:String;
	
	static function readDir(dirpath:String):Promise<Array<ReadDirItem>>;
	static function readDirAssets(dirpath:String):Promise<Array<ReadDirItem>>;
	static function readdir(dirpath:String):Promise<Array<String>>;
	static function stat(filepath:String):Promise<StatResult>;
	static function readFile(filepath:String, ?encoding:String):Promise<String>;
	static function readFileAssets(filepath:String, ?encoding:String):Promise<String>;
	static function writeFile(filepath:String, contents:String, ?encoding:String):Promise<Void>;
	static function appendFile(filepath:String, contents:String, ?encoding:String):Promise<Void>;
	static function moveFile(filepath:String, destPath:String):Promise<Void>;
	static function copyFile(filepath:String, destPath:String):Promise<Void>;
	static function copyFileAssets(filepath:String, destPath:String):Promise<Void>;
	static function unlink(filepath:String):Promise<Void>;
	static function exists(filepath:String):Promise<Bool>;
	static function existsAssets(filepath:String):Promise<Bool>;
	static function hash(filepath:String, algorithm:String):Promise<String>;
	static function mkdir(filepath:String, ?options:MkdirOptions):Promise<Void>;
	static function downloadFile(options:DownloadFileOptions):{jobId:Int, promise:Promise<DownloadResult>}
	static function stopDownload(jobId:Int):Promise<Void>;
	static function uploadFiles(options:UploadFileOptions):{jobId:Int, promise:Promise<UploadResult>}
	static function stopUpload(jobId:Int):Promise<Void>;
	static function getFSInfo():Promise<FSInfoResult>;
}

typedef Headers = haxe.DynamicAccess<String>;
typedef Fields = haxe.DynamicAccess<String>;

typedef ReadDirItem = {
	name:String,     // The name of the item
	path:String,     // The absolute path to the item
	size:Int,     // Size in bytes. 
						// Note that the size of files compressed during the creation of the APK (such as JSON files) cannot be determined. 
						// `size` will be set to -1 in this case.
	isFile:Void->Bool,        // Is the file just a file?
	isDirectory:Void->Bool,   // Is the file a directory?
}

typedef StatResult = {
	name:String,     // The name of the item
	path:String,     // The absolute path to the item
	size:Int,     // Size in bytes
	mode:Int,     // UNIX file mode
	isFile:Void->Bool,        // Is the file just a file?
	isDirectory:Void->Bool,   // Is the file a directory?
}
typedef MkdirOptions = {
	?NSURLIsExcludedFromBackupKey:Bool, // iOS only
}

typedef DownloadFileOptions = {
	fromUrl:String,          // URL to download file from
	toFile:String,           // Local filesystem path to save the file to
	?headers:Headers,        // An object of headers to be passed to the server
	?background:Bool,
	?progressDivider:Int,
	?begin:DownloadBeginCallbackResult->Void,
	?progress:DownloadProgressCallbackResult->Void,
}

typedef DownloadResult = {
	jobId:Int,          // The download job ID, required if one wishes to cancel the download. See `stopDownload`.
	statusCode:Int,     // The HTTP status code
	bytesWritten:Int,   // The number of bytes written to the file
}

typedef DownloadBeginCallbackResult = {
	jobId:Int,          // The download job ID, required if one wishes to cancel the download. See `stopDownload`.
	statusCode:Int,     // The HTTP status code
	contentLength:Int,  // The total size in bytes of the download resource
	headers:Headers,       // The HTTP response headers from the server
}

typedef DownloadProgressCallbackResult = {
	jobId:Int,          // The download job ID, required if one wishes to cancel the download. See `stopDownload`.
	contentLength:Int,  // The total size in bytes of the download resource
	bytesWritten:Int,   // The number of bytes written to the file so far
}

typedef UploadFileOptions = {
	toUrl:String,            // URL to upload file to
	files:Array<UploadFileItem>,  // An array of objects with the file information to be uploaded.
	?headers:Headers,        // An object of headers to be passed to the server
	?fields:Fields,          // An object of fields to be passed to the server
	?method:String,          // Default is 'POST', supports 'POST' and 'PUT'
	?begin:UploadBeginCallbackResult->Void,
	?progress:UploadProgressCallbackResult->Void,
}

typedef UploadResult = {
	jobId:Int,        // The upload job ID, required if one wishes to cancel the upload. See `stopUpload`.
	statusCode:Int,   // The HTTP status code
	headers:Headers,     // The HTTP response headers from the server
	body:String,         // The HTTP response body
}

typedef UploadFileItem = {
	name:String,       // Name of the file, if not defined then filename is used
	filename:String,   // Name of file
	filepath:String,   // Path to file
	filetype:String,   // The mimetype of the file to be uploaded, if not defined it will get mimetype from `filepath` extension
}

typedef UploadBeginCallbackResult = {
	jobId:Int,        // The upload job ID, required if one wishes to cancel the upload. See `stopUpload`.
}

typedef UploadProgressCallbackResult = {
	jobId:Int,                      // The upload job ID, required if one wishes to cancel the upload. See `stopUpload`.
	totalBytesExpectedToSend:Int,   // The total number of bytes that will be sent to the server
	totalBytesSent:Int,             // The number of bytes sent to the server
}

typedef FSInfoResult = {
	totalSpace:Int,   // The total amount of storage space on the device (in bytes).
	freeSpace:Int,    // The amount of available storage space on the device (in bytes).
}