import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class FilePickerIconButton extends ImageButton {
  final String? dialogTitle;
  final FileType type;
  final List<String>? allowedExtensions;
  final dynamic Function(FilePickerStatus)? onFileLoading;
  final dynamic Function(FilePickerResult?)? onFileSelected;
  final dynamic Function(String?)? onDirectirySelected;
  final String? initialDirectory;
  final bool allowCompression;
  final bool allowMultiple;
  final bool withData;
  final bool withReadStream;
  final bool lockParentWindow;
  final bool pickDirectory;

  FilePickerIconButton({
    super.key,
    super.icon = const Icon(Icons.file_upload),
    this.dialogTitle,
    this.type = FileType.any,
    this.allowedExtensions,
    this.onFileLoading,
    this.onFileSelected,
    this.onDirectirySelected,
    this.initialDirectory,
    this.allowCompression = true,
    this.allowMultiple = false,
    this.withData = false,
    this.withReadStream = false,
    this.lockParentWindow = true,
    this.pickDirectory = false,
  }) : super(onPressed: () async {
          if (!pickDirectory) {
            var result = await FilePicker.platform.pickFiles(
              dialogTitle: dialogTitle,
              type: type,
              allowedExtensions: allowedExtensions,
              onFileLoading: onFileLoading,
              allowCompression: allowCompression,
              allowMultiple: allowMultiple,
              withData: withData,
              withReadStream: withReadStream,
              lockParentWindow: lockParentWindow,
              initialDirectory: initialDirectory,
            );
            if (onFileSelected != null) {
              onFileSelected(result);
            }
          } else {
            var result = await FilePicker.platform.getDirectoryPath(
              dialogTitle: dialogTitle,
              lockParentWindow: lockParentWindow,
              initialDirectory: initialDirectory,
            );
            if (onDirectirySelected != null) {
              onDirectirySelected(result);
            }
          }
        });
}
