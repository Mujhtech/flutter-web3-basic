import 'package:flutter/material.dart';
import 'package:flutter_web3_basic/models/forum.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:jazzicon/jazziconshape.dart';

class Message extends StatefulWidget {
  final Forum forum;
  const Message({super.key, required this.forum});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  JazziconData? jazz;

  @override
  void initState() {
    jazz = Jazzicon.getJazziconData(40, address: widget.forum.owner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (jazz != null) Jazzicon.getIconWidget(jazz!),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 100,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '0x008c2cf1a4d998ed72917c885e6942706eb66137',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.forum.message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
