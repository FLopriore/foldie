import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldie/providers/devices_provider.dart';
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
          String extension = p.extension(element);
          return GestureDetector(
            onTap: () {
              _selectedElementIndex = index;
              appState.selectFile(index);
            },
            onDoubleTap: () {
              appState.currentPath += "/$element";
              appState.getFilesInPath();
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
                  appState.currentPath += "/$element";
                  appState.getFilesInPath();
                },
              ),
              leading: Icon(
                (extension.isEmpty)
                    ? CupertinoIcons.folder_fill
                    : CupertinoIcons.doc_fill,
                color: Colors.white,
              ),
            ),
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
