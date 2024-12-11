import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iclinix/app/drawer/help_screen.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';

import '../../../controller/chat_controller.dart';

class AllTicketsScreen extends StatefulWidget {
  const AllTicketsScreen({super.key});

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Code here runs after the first frame is rendered
      print('First frame rendered!');
      Get.find<ChatController>().getTickets();
    });

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (chatControl) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: "Your issues",
          isBackButtonExist: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatControl.allTickets.length,
                  itemBuilder: (context, index) {

                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 2,
                        shadowColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade200, width: 1)
                        ),
                        child:  ListTile(
                          onTap: (){
                             chatControl.getSingleTicketReplies(chatControl.allTickets[index].id.toString() ?? "");
                          },
                          style: ListTileStyle.list,
                          splashColor: Colors.grey,
                          title: Text(
                            chatControl.allTickets[index].ticketType!.type ??"" ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Tap To Ope Chat"),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      );

    });


  }
}
