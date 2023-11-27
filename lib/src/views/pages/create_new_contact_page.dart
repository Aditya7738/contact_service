import 'package:contact_service/src/core/common_widgets/app_text_form_field.dart';
import 'package:contact_service/src/core/constant/strings.dart';
import 'package:contact_service/src/core/helpers/validation_helper.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class CreateNewContact extends StatefulWidget {
  const CreateNewContact({super.key});

  @override
  State<CreateNewContact> createState() => _CreateNewContactState();
}

class _CreateNewContactState extends State<CreateNewContact> {
  late String displayName;
  late String familyName;
  late Item phone;
  List<Item> phones = [];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController firstDisplayNameController =
        TextEditingController();
    final TextEditingController lastFamilyNameController =
        TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleOfSaveContact),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, //y-axis
              children: [
                AppTextFormField(
                  label: Strings.displayName,
                  textEditingController: firstDisplayNameController,
                  validator: ValidationHelper.validateDisplayName,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                AppTextFormField(
                  label: Strings.familyName,
                  textEditingController: lastFamilyNameController,
                  validator: ValidationHelper.validateFamilyName,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                AppTextFormField(
                  label: Strings.phoneNo,
                  textEditingController: phoneController,
                  validator: ValidationHelper.validatePhone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    onPressed: () {


                      if (formKey.currentState?.validate() ?? false) {
                        displayName = firstDisplayNameController.text;
                        familyName = lastFamilyNameController.text;
                        phone = Item(value: phoneController.text);
                        phones.add(phone);
                      }


                      Contact contact = Contact(
                        displayName: displayName,
                        familyName: familyName,
                        phones: phones
                      );

                      Navigator.pop(context, contact);
                    },
                    child: const Text(Strings.titleOfSaveContact)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
