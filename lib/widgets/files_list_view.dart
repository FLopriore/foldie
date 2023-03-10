import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/widgets/custom_icon.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class FilesListView extends StatefulWidget {
  const FilesListView({super.key});

  @override
  State<FilesListView> createState() => _FilesListViewState();
}

class _FilesListViewState extends State<FilesListView> {
  // By default no file or folder is selected.
  int _selectedElementIndex = -1;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    TextStyle textStyle = CupertinoTheme.of(context).textTheme.textStyle;
    Widget content;

    if (appState.filesList.isEmpty) {
      content = Center(
        child: Text(
          'Folder is empty.',
          style: textStyle,
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: appState.filesList.length,
        itemBuilder: (BuildContext context, int index) {
          String element = appState.filesList.elementAt(index);
          // Checks if element is a folder or a file. The former has an empty
          // extension, the latter doesn't.
          bool isFolder = p.extension(element).isEmpty;
          return GestureDetector(
            onTap: () {
              _selectedElementIndex = index;
              appState.selectFile(index);
            },
            onDoubleTap: () {
              // If element is a folder, enters this folder
              if (isFolder) {
                appState.currentPhonePath += "/$element";
                appState.getFilesInPath();
              }
            },
            child: ListTile(
                selectedTileColor: CupertinoColors.activeBlue,
                title: Text(
                  element,
                  style: textStyle,
                ),
                selected: index == _selectedElementIndex,
                trailing: IconButton(
                  icon: const Icon(
                    CupertinoIcons.forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    appState.currentPhonePath += "/$element";
                    appState.getFilesInPath();
                  },
                ),
                leading: CustomIcon(
                    icon: (isFolder)
                        ? "assets/folder.png"
                        : "assets/document.png")),
          );
        },
      );
    }

    return Material(
      color: const Color(0xff3a3a3c),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: content,
    );
  }
}
