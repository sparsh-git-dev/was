import 'package:aws_flutter/feature/dynamic_form/controller/form_screen_controller.dart';
import 'package:aws_flutter/feature/dynamic_form/view/dynamic_form.dart';
import 'package:aws_flutter/global/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../model/gram_power_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final FormScreenController _controller;
  @override
  void initState() {
    super.initState();
    _controller = Get.put(FormScreenController());
    _controller.fetchGramPowerData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormScreenController>(
        id: "main",
        builder: (logic) {
          return Scaffold(
            body: logic.isLoading
                ? const Center(child: Loader())
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              logic.model?.formName ?? "",
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                          const Expanded(child: DynamicForm()),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: OutlinedButton(
                                onPressed: () async {
                                  logic.formKey.currentState?.validate();
                                  await logic.saveData();
                                },
                                child: const Text("SUBMIT")),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
