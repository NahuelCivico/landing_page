import 'package:fluro/fluro.dart';
import 'package:landing_page/providers/page_provider.dart';
import 'package:landing_page/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    //Routes
    router.define(
      '/:page',
      handler: Handler(
        handlerFunc: (context, Map<String, List<String>> params) {
          final page = params['page']?.first;
          if (page != '/') {
            final pageProvider =
                Provider.of<PageProvider>(context!, listen: false);
            pageProvider.createScrollController(page!);
            return const HomePage();
          }
          return null;
        },
      ),
    );

    //404
    router.notFoundHandler = Handler(
      handlerFunc: (context, Map<String, List<String>> params) {
        return const HomePage();
      },
    );
  }
}
