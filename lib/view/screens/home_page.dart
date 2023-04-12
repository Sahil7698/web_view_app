import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'bookmark_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late InAppWebViewController myWeb;

  String data = "Flutter";
  String myUrl =
      "https://www.google.co.in/search?q=fltter&sxsrf=AJOqlzUScL6Viw5GpGgZtgaa6z6HOLnNtA%3A1677739720140&source=hp&ei=yEYAZM-hBsTh-AaqiIMw&iflsig=AK50M_UAAAAAZABU2ICFh903uWpMamEphozl_l-W39Tb&ved=0ahUKEwjPpavA07z9AhXEMN4KHSrEAAYQ4dUDCAg&uact=5&oq=fltter&gs_lcp=Cgdnd3Mtd2l6EAMyBwgjELECECcyBwgjELECECcyBwgjELECECcyBwgAEIAEEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyCggAEIAEELEDEAoyBQgAELEDMg0IABCABBCxAxCDARAKOgUIABCABDoQCAAQgAQQsQMQgwEQsQMQClAAWO8GYJQJaABwAHgAgAHcAYgBxAWSAQUwLjMuMZgBAKABAQ&sclient=gws-wiz";

  String currentUrl = "";

  bool canGoBack = false;
  bool canGoForward = false;

  List history = [];
  List bookMark = [];

  double progress = 0;
  late PullToRefreshController refreshController;

  @override
  void initState() {
    super.initState();
    myUrl =
        "https://www.google.co.in/search?q=$data&sxsrf=AJOqlzUScL6Viw5GpGgZtgaa6z6HOLnNtA%3A1677739720140&source=hp&ei=yEYAZM-hBsTh-AaqiIMw&iflsig=AK50M_UAAAAAZABU2ICFh903uWpMamEphozl_l-W39Tb&ved=0ahUKEwjPpavA07z9AhXEMN4KHSrEAAYQ4dUDCAg&uact=5&oq=$data&gs_lcp=Cgdnd3Mtd2l6EAMyBwgjELECECcyBwgjELECECcyBwgjELECECcyBwgAEIAEEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyCggAEIAEELEDEAoyBQgAELEDMg0IABCABBCxAxCDARAKOgUIABCABDoQCAAQgAQQsQMQgwEQsQMQClAAWO8GYJQJaABwAHgAgAHcAYgBxAWSAQUwLjMuMZgBAKABAQ&sclient=gws-wiz";

    refreshController = PullToRefreshController(
      onRefresh: () {
        setState(() {
          setState(() {
            refreshController.endRefreshing();
          });
        });
      },
      options: PullToRefreshOptions(
        enabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await myWeb.canGoBack()) {
          myWeb.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onChanged: (v) => setState(() => data = v),
                        onSubmitted: (v) {
                          setState(() {
                            history.add(data);
                            myUrl =
                                "https://www.google.co.in/search?q=$data&sxsrf=AJOqlzUScL6Viw5GpGgZtgaa6z6HOLnNtA%3A1677739720140&source=hp&ei=yEYAZM-hBsTh-AaqiIMw&iflsig=AK50M_UAAAAAZABU2ICFh903uWpMamEphozl_l-W39Tb&ved=0ahUKEwjPpavA07z9AhXEMN4KHSrEAAYQ4dUDCAg&uact=5&oq=$data&gs_lcp=Cgdnd3Mtd2l6EAMyBwgjELECECcyBwgjELECECcyBwgjELECECcyBwgAEIAEEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyDQgAEIAEELEDEIMBEAoyCggAEIAEELEDEAoyBQgAELEDMg0IABCABBCxAxCDARAKOgUIABCABDoQCAAQgAQQsQMQgwEQsQMQClAAWO8GYJQJaABwAHgAgAHcAYgBxAWSAQUwLjMuMZgBAKABAQ&sclient=gws-wiz";
                            myWeb.loadUrl(
                                urlRequest: URLRequest(url: Uri.parse(myUrl)));
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookMark(bookMark: bookMark),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.bookmark_add,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: (progress < 1),
                child: LinearProgressIndicator(
                  value: progress,
                ),
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: InAppWebView(
                      onWebViewCreated: (controller) async {
                        myWeb = controller;
                      },
                      onProgressChanged: (controller, P) {
                        setState(() {
                          progress = P.toDouble();
                        });
                      },
                      pullToRefreshController: refreshController,
                      onLoadStart: (con, c) async {
                        Uri? dummy = await myWeb.getUrl();
                        currentUrl = dummy!.scheme;
                        this.currentUrl = c.toString();
                        canGoBack = await myWeb.canGoBack();
                        canGoForward = await myWeb.canGoForward();
                        setState(() {});
                      },
                      onLoadStop:
                          (InAppWebViewController controller, Uri? url) async {
                        this.currentUrl = url.toString();
                        refreshController.endRefreshing();
                      },
                      initialUrlRequest: URLRequest(url: Uri.parse(myUrl)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                myWeb.goBack();
              },
              child: const Icon(Icons.arrow_back_ios_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: ElevatedButton(
                onPressed: () {
                  myWeb.reload();
                },
                child: const Icon(Icons.refresh),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    bookMark.contains(currentUrl)
                        ? bookMark.remove(currentUrl)
                        : bookMark.add(currentUrl);
                  });
                },
                child: Icon(
                  (bookMark.contains(currentUrl))
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: ElevatedButton(
                onPressed: () {
                  myWeb.goForward();
                },
                child: const Icon(Icons.cancel_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: ElevatedButton(
                onPressed: () {
                  myWeb.goForward();
                },
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
