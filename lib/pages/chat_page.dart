import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/modals/message.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  TextEditingController controller = TextEditingController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  final ScrollController _controller = ScrollController();

  String _enteredMessage = "";

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text("Chat"),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble(
                                  message: messagesList[index],
                                )
                              : ChatBubbleForFriend(
                                  message: messagesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      onChanged: (data) {
                        _enteredMessage = data;
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message...',
                        suffixIcon: IconButton(
                          icon:const Icon(
                            Icons.send,
                          ),
                          onPressed: () {
                            _enteredMessage.trim().isEmpty
                                ? null
                                : messages.add({
                                    kMessage: _enteredMessage,
                                    kCreatedAt: DateTime.now(),
                                    'id': email,
                                  });
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _enteredMessage = "";
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: const Duration(microseconds: 500),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
