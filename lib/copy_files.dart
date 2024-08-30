import 'dart:io';

void main() {
  final currentDir = Directory.current;
  final outputDir = Directory('all_files');

  // Create the output directory if it doesn't exist
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
    print('Created directory: ${outputDir.path}');
  } else {
    print('Directory already exists: ${outputDir.path}');
  }

  void copyFile(File sourceFile, Directory targetDir) {
    try {
      String fileName = sourceFile.uri.pathSegments.last;

      // Initialize the target file path
      String targetPath = '${targetDir.path}/$fileName';
      File targetFile = File(targetPath);

      // Handle potential filename conflicts
      int counter = 1;
      String fileNameWithoutExtension;
      String fileExtension;

      if (fileName.contains('.')) {
        int lastDot = fileName.lastIndexOf('.');
        fileNameWithoutExtension = fileName.substring(0, lastDot);
        fileExtension = fileName.substring(lastDot);
      } else {
        fileNameWithoutExtension = fileName;
        fileExtension = '';
      }

      // Append counter until a unique filename is found
      while (targetFile.existsSync()) {
        String newFileName =
            '${fileNameWithoutExtension}_$counter$fileExtension';
        targetPath = '${targetDir.path}/$newFileName';
        targetFile = File(targetPath);
        counter++;
      }

      // Copy the file
      sourceFile.copySync(targetPath);
      print('Copied: ${sourceFile.path} -> $targetPath');
    } catch (e) {
      print('Error copying file ${sourceFile.path}: $e');
    }
  }

  // Recursively find and copy all files to the output directory
  // Exclude the output directory itself to prevent infinite loops
  void copyFiles(Directory dir) {
    try {
      for (var entity in dir.listSync(recursive: false)) {
        if (entity is File) {
          copyFile(entity, outputDir);
        } else if (entity is Directory && entity.path != outputDir.path) {
          copyFiles(entity);
        }
      }
    } catch (e) {
      print('Error accessing directory ${dir.path}: $e');
    }
  }


  // Start copying files from the current directory
  copyFiles(currentDir);

  print('All files have been copied to ${outputDir.path}');
}
