part of 'app_widgets.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const AppScaffold({
    this.body = const SizedBox.expand(),
    this.floatingActionButton,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
      );
}
