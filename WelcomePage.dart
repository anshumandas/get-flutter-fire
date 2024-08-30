import 'package:e_book_marketplace/Components/PrimaryButton.dart';
//import 'package:e_book_marketplace/Controller/AuthController.dart';
import 'package:e_book_marketplace/Pages/Homepage/HomePage.dart';                         // check it once
import 'package:flutter/material.dart';
import 'package:get/get.dart';    

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 450,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      "Assets/Images/book.png",
                      width: 380,
                    ),
                    const SizedBox(height: 60),
                    Text(
                      "E - Book Store",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        "Here, you can find the perfect book for you and easily enjoy reading or listening to it",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Disclaimer",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "By using E - Book Store, you acknowledge that eBooks are for personal use and may be subject to copyright laws. We ensure data security but disclaim responsibility for content accuracy or legality",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryButton(
              btnName: "CONTINUE",
              ontap: () {
                Get.offAll(HomePage());
              },
            ),
          )
        ],
      ),
    );
  }
}
