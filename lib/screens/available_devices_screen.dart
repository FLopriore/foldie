import 'package:flutter/cupertino.dart';
import 'package:foldie/widgets/devices_list_view.dart';
import 'package:foldie/widgets/connect_button.dart';
import 'package:foldie/widgets/update_button.dart';

class AvailableDevicesPage extends StatelessWidget {
  const AvailableDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = CupertinoTheme.of(context).textTheme.textStyle;
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Available devices",
              style: textStyle.copyWith(fontWeight: FontWeight.w200),
            ),
            const SizedBox(height: 20),
            const DevicesListView(),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: const [
                  ConnectButton(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: UpdateButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
