import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final MyHomePageController controller = Get.put(MyHomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('收入計算'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 男方薪資輸入框
              TextField(
                controller: controller.manSalaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '男方薪資',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.amountMan = int.parse(value);
                },
              ),
              const SizedBox(height: 16),
              // 男方股利輸入框
              TextField(
                controller: controller.manDividendController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '男方股利',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.dividendMan = int.parse(value);
                },
              ),
              const SizedBox(height: 16),
              // 女方薪資輸入框
              TextField(
                controller: controller.womanSalaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '女方薪資',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.amountGirl = int.parse(value);
                },
              ),
              const SizedBox(height: 16),
              // 女方股利輸入框
              TextField(
                controller: controller.womanDividendController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '女方股利',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.dividendGirl = int.parse(value);
                },
              ),
              Obx(() => Text(controller.message.value)),
              GestureDetector(
                  onTap: () {
                    controller.check();
                  },
                  child: Text('計算'))
            ],
          ),
        ),
      ),
    );
  }
}
