import 'dart:math';

import 'package:contact_service/src/views/pages/create_new_contact_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constant/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contactList = [];

  bool isLoading = true;

  late Contact contact;

  @override
  void initState() {
    super.initState();
    getContactPermission();

  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContact();
    } else {
      await Permission.contacts.request();
    }
  }

  void fetchContact() async {
    contactList = await ContactsService.getContacts();
    setState(() {
      isLoading = false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.titleOfApp),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 30.0,
                    width: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.white.withOpacity(0.1),
                          offset: const Offset(-3, -3),
                        ),
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(3, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xff262626),
                    ),
                    child:
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                                "${contactList[index].displayName?.substring(0,1)}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.primaries[
                                        Random().nextInt(Colors.primaries.length)],
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w500),
                              ),
                    ),


                  ),

                  title:  Text(
                    contactList[index].displayName.toString(),
                        //" ${contactList[index].familyName.toString()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: Strings.fontFamily,
                              fontWeight: FontWeight.w500),
                        ),

                  subtitle:

                  Text(

                    contactList[index].phones != null && contactList[index].phones!.isNotEmpty
                        ?
                    contactList[index].phones![0].value.toString() :
                        Strings.nullValue,
                          style: const TextStyle(
                              fontSize: 11.0,
                              color: Color(0xffC4c4c4),
                              fontFamily: Strings.fontFamily,
                              fontWeight: FontWeight.w400),
                        ),

                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          contact = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewContact()));

          setState((){
            contactList.add(contact);
          });

          },
        tooltip: Strings.addToolTip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
