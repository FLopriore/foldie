import 'package:flutter/cupertino.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/widgets/files_list_view.dart';
import 'package:foldie/widgets/mac_path_text_field.dart';
import 'package:foldie/widgets/side_bar.dart';
import 'package:provider/provider.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return CupertinoPageScaffold(
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: SideBar(),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 10,
                        child: MacPathTextField(),
                      ),
                      const SizedBox(width: 10),
                      CupertinoButton.filled(
                          child: const Text(
                            "Browse...",
                            style: TextStyle(
                                color: CupertinoColors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            appState.getMacDirectoryPath();
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Expanded(child: FilesListView()),
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    child: const Text(
                      "Copy",
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    onPressed: () => appState.transferFiles(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
