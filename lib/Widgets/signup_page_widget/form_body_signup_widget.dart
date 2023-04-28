import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/signup_controller.dart';
import 'package:meditation_app/model/users_model.dart';

// ignore: camel_case_types, must_be_immutable
class form_body_signup_widget extends StatefulWidget {
  form_body_signup_widget({
    super.key,
    required this.size,
    required this.sHeight,
    required this.sWidth,
    required this.sHeightTF,
    required this.sWidthTF,
    this.sFooter,
  });

  final MaterialStateProperty<Size> size;
  final double sHeight, sWidth, sHeightTF, sWidthTF;
  late double? sFooter;

  @override
  State<form_body_signup_widget> createState() =>
      _form_body_signup_widgetState();
}

class _form_body_signup_widgetState extends State<form_body_signup_widget> {
  final ValueNotifier<bool> _showError = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final siree = context.screenSize;
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    final ValueNotifier<bool> isHidenPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenRePass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isCheckbox = ValueNotifier<bool>(false);
    String passwordError = "";
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(0),
        width: widget.sWidth,
        height: widget.sHeight,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: widget.sHeightTF,
              width: widget.sWidthTF,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.1),
                  )
                ],
              ),
              child: TextField(
                controller: controller.userName,
                decoration: InputDecoration(
                  prefixIcon: Image.asset(imgUser),
                  fillColor: const Color(0xFFF2F3F7),
                  filled: true,
                  hintText: txtUsername,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.1),
                    )
                  ]),
              child: SizedBox(
                height: widget.sHeightTF,
                width: widget.sWidthTF,
                // xây dựng lại widget mỗi khi biến a thay đổi
                child: ValueListenableBuilder(
                  valueListenable: isHidenPass,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return TextField(
                      controller: controller.passWord,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !value,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(imgLock),
                        fillColor: const Color(0xFFF2F3F7),
                        filled: true,
                        hintText: txtPassword,

                        //helperText: passwordError,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                        ),
                        suffix:
                            //Image.asset('assets/images/ic_hide.png'),
                            GestureDetector(
                          onTap: () {
                            isHidenPass.value = !isHidenPass.value;
                          },
                          child: Icon(
                            isHidenPass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        passwordError = controller
                            .validatePassword(controller.passWord.text.trim());
                        _showError.value = false;
                      },
                    );
                  },
                ),
              ),
            ),
            // at least one uppercase letter, one lowercase letter,\n one special character and number'
            ValueListenableBuilder(
              valueListenable: _showError,
              builder: (context, value, child) {
                return _showError.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          passwordError,
                          style:
                              Primaryfont.bold(12).copyWith(color: Colors.red),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.1),
                  )
                ],
              ),
              child: SizedBox(
                height: widget.sHeightTF,
                width: widget.sWidthTF,
                child: ValueListenableBuilder(
                  valueListenable: isHidenRePass,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return TextField(
                      controller: controller.rePassWord,
                      obscureText: !isHidenRePass.value,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Image.asset(imgLock),
                        fillColor: const Color(0xFFF2F3F7),
                        filled: true,
                        hintText: txtRePassword,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            isHidenRePass.value = !isHidenRePass.value;
                          },
                          child: Icon(
                            isHidenRePass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              child: FittedBox(
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: txtHaveRead,
                        style: Primaryfont.medium(14).copyWith(
                          color: kColorDartPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: txtPrivacePolicy,
                            style: Primaryfont.medium(14)
                                .copyWith(color: kColorPrimary, height: 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isCheckbox,
                      builder: (context, value, child) {
                        return Checkbox(
                          value: isCheckbox.value,
                          onChanged: (bool? value) {
                            isCheckbox.value = !isCheckbox.value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: widget.sFooter,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  String formattedDate = DateFormat('dd, MMMM, yyyy').format(DateTime.now());
                  final rePassWord = controller.rePassWord.text.trim();
                  final users = UsersModel(
                    userName: controller.userName.text.trim(),
                    passWord: controller.passWord.text.trim(),
                    joinDay: formattedDate
                  );
                  try {
                    bool isValid =
                        await controller.checkUserName(users.userName);
                    if (users.userName == "" ||
                        users.passWord == "" ||
                        rePassWord == "") {
                      // final snackBar = SnackBar(
                      //   content: CustomSnackBarWidget(
                      //     sizeWidth: siree.width * 0.5,
                      //     title: 'Error !',
                      //     subTitle:
                      //         'You have not entered the complete information?',
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      //   elevation: 0,
                      //   behavior: SnackBarBehavior.floating,
                      //   duration: const Duration(seconds: 2),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.snackbar("Error!", "You have not entered the complete information?.",
                        icon: const Icon(Icons.error, color: Colors.white),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);                     
                    } else if (controller.isPasswordValid(users.passWord) ==
                        false) {
                      _showError.value = true;
                    } else if (rePassWord != users.passWord) {
                      // final snackBar = SnackBar(
                      //   content: CustomSnackBarWidget(
                      //     sizeWidth: siree.width,
                      //     title: 'Error !',
                      //     subTitle: 'Password incorrect? Try again.',
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      //   elevation: 0,
                      //   behavior: SnackBarBehavior.floating,
                      //   duration: const Duration(seconds: 2),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       Get.snackbar("Error!", "Password incorrect? Try again.",
                        icon: const Icon(Icons.error, color: Colors.white),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);            
                    } else if (isCheckbox.value == false) {
                      // final snackBar = SnackBar(
                      //   content: CustomSnackBarWidget(
                      //       sizeWidth: siree.width,
                      //       title: 'Error !',
                      //       subTitle: 'You have not accepted the terms!'),
                      //   backgroundColor: Colors.transparent,
                      //   elevation: 0,
                      //   behavior: SnackBarBehavior.floating,
                      //   duration: const Duration(seconds: 2),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       Get.snackbar("Error!", "You have not accepted the terms.",
                        icon: const Icon(Icons.error, color: Colors.white),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);     
                    } else if (isValid) {
                      // final snackBar = SnackBar(
                      //   content: CustomSnackBarWidget(
                      //       sizeWidth: siree.width,
                      //       title: 'Error !',
                      //       subTitle: 'Username already exists.'),
                      //   backgroundColor: Colors.transparent,
                      //   elevation: 0,
                      //   behavior: SnackBarBehavior.floating,
                      //   duration: const Duration(seconds: 2),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.snackbar("Error!", "Username already exists.",
                        icon: const Icon(Icons.error, color: Colors.white),
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red,
                        colorText: Colors.white);     
                    } else {
                      SignUpController.instance.creadUser(users);
                      Get.off(() => const SignIn());
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print('Error: $e');
                    }
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kColorPrimary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
                fixedSize: widget.size,
              ),
              child: Text(
                txtSignUp,
                style: Primaryfont.bold(14).copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
