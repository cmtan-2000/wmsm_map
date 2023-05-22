import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/provider/example-changenotifier.dart';
import '../viewmodel/provider/example-futureprovider.dart';
import '../viewmodel/provider/example-streamprovider.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          title: const Text('Provider Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<MessageViewModel>(
                builder: (context, message, child) => Column(
                  children: [
                    const Text(
                      'ChangeNotifierProvider',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message.value.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        message.value == ''
                            ? message.update("You just pass Message")
                            : message.update("");
                      },
                      child: message.value == ''
                          ? const Text('Update Message')
                          : const Text('Clear Message'),
                    ),
                  ],
                ),
              ),
              Consumer<List<dynamic>>(
                builder: (context, data1, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FutureProvider',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'String: ${data1[0]} - ',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Number: ${data1[1]} - ',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Boolean: ${data1[2]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    // FutureBuilder(
                    //   future: FutureViewModel().getFutureList(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<List<dynamic>> snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Center(
                    //           child: CircularProgressIndicator());
                    //     }
                    //     if (snapshot.hasData) {
                    //       return Column(
                    //         children: [
                    //           Text(
                    //             'String: ${snapshot.data![0]} - ',
                    //             style: const TextStyle(fontSize: 16),
                    //           ),
                    //           Text(
                    //             'Number: ${snapshot.data![1]} - ',
                    //             style: const TextStyle(fontSize: 16),
                    //           ),
                    //           Text(
                    //             'Boolean: ${snapshot.data![2]}',
                    //             style: const TextStyle(fontSize: 16),
                    //           ),
                    //         ],
                    //       );
                    //     }
                    //     return const Text('FutureBuilder error');
                    //   },
                    // )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'StreamProvider',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Consumer<String>(
                    builder: (context, data, _) => Text(
                      'String from StreamProvider: $data',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Consumer<int>(
                    builder: (context, count, _) => Text(
                      'Integer from StreamProvider: $count',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  // StreamBuilder(
                  //   stream: StreamViewModel().fetchData1(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<dynamic> snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Text(
                  //         'String from StreamBuilder: ${snapshot.data}',
                  //         style: const TextStyle(fontSize: 16),
                  //       );
                  //     } else {
                  //       return const Text(
                  //         'String from StreamBuilder: Loading...',
                  //         style: TextStyle(fontSize: 16),
                  //       );
                  //     }
                  //   },
                  // )
                ],
              ),
              Consumer<bool>(
                builder: (context, data, _) => Text(
                  'ProxyProvider: $data',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
