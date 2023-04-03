import 'package:flutter/cupertino.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/widgets/files_list_view.dart';
import 'package:foldie/widgets/mac_file_picker.dart';
import 'package:foldie/widgets/path_text.dart';
import 'package:foldie/widgets/side_bar.dart';
import 'package:foldie/widgets/custom_icon_button.dart';
import 'package:foldie/widgets/transfer_button.dart';
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
                  const MacFilePicker(),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        const Text(
                          "Phone path: ",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Expanded(
                            child: PathText(path: appState.currentPhonePath)),
                        CustomIconButton(
                          icon: CupertinoIcons.arrow_up,
                          color: CupertinoColors.white,
                          iconSize: 20,
                          onPressed: () => appState.moveToParentDirectory(),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: FilesListView()),
                  const SizedBox(height: 20),
                  const TransferButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
