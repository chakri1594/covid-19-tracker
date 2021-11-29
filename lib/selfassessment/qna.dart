import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class QNA extends StatefulWidget{
  @override
  _QNAState createState() => _QNAState();
}

class _QNAState extends State<QNA> {
  final bot = ChatUser(uid: 'bot');

  final user = ChatUser(uid: 'user');

  List<ChatMessage> conversation = [];

  double sum = 0;

  double major = 0.25;
  double minor = 0.15;
  bool isLodding = true;

  List<ChatMessage> chats;

  String result = "";

  @override
  void initState() {
    super.initState();
    //controller.addListener(on);
    chats = [
      ChatMessage(
          text: 'What is your age?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: "Youth (15-24 years)",
              value: minor.toString(),
            ),
            Reply(
              title: " Adults (25-64 years)",
              value: minor.toString(),
            ),
            Reply(
              title: 'Seniors (65 years and over)',
              value: '0.75',
            ),
          ])),
      ChatMessage(
          text: 'What sex were you assigned at birth, on your original birth certificate?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: 'MALE',
              value: 0.toString(),
            ),
            Reply(
              title: " FEMALE",
              value: 0.toString(),
            ),
            Reply(
              title: "PREFER NOT TO SAY",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
          text: "Do you have any of these life-threatening symptoms? \n\n Trouble breathing \n Persistent pain or pressure in the chest\n New confusion\n Inability to wake or stay awake\n Pale, gray, or blue-colored skin, lips, or nail beds, depending on skin tones \n\n*This list is not all possible symptoms. Please call your medical provider for any other symptoms that are severe or concerning to you.",
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " Yes",
              value: major.toString(),
            ),
            Reply(
              title: " No",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
        text: "In the last two weeks, have you been in close contact with someone who has COVID-19?\n\n You have been in close contact if you have\na. been within 6 feet of someone who has COVID-19 for a combined total of 15 minutes or more over a 24 hour period or\nb. provided care at home to someone who is sick with COVID-19 or\nc. had direct physical contact (hugged or kissed) with someone who has COVID-19 or\nd. shared eating or drinking utensils with someone who has COVID-19 or\ne. been sneezed on or coughed on by someone who has COVID-19",
        user: bot,
        quickReplies: QuickReplies(values: [
          Reply(
            title: " YES",
            value: major.toString(),
          ),
          Reply(
            title: " NO",
            value: 0.toString(),
          ),
          Reply(
            title: " I DON'T KNOW",
            value: minor.toString(),
          ),
        ]),
      ),
      ChatMessage(
          text: 'Have you been recently tested positive for COVID 19?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(title: " YES",
                value:  major.toString(),
            ),
            Reply(
              title: " NO",
              value: '0',
            ),
            Reply(
              title: " I have not been tested .",
              value: '0.10',
            ),
          ])),
      ChatMessage(
          text: 'Are you currently experiencing any of these issues? Call 911 if you are.\n\n Severe difficulty breathing\n (struggling for each breath, can only speak in single words)\n Severe chest pain\n (constant tightness or crushing sensation)\n Feeling confused or unsure of where you are\n Losing consciousness',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " Yes",
              value: '0.15',
            ),
            Reply(
              title: " No",
              value: '0',
            ),
          ])),
      ChatMessage(
          text: "Do you live in a long-term care facility, nursing home, homeless shelter, or housing at an institution of higher education?",
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " YES",
              value: minor.toString(),
            ),
            Reply(
              title: " NO",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
         // text: "",
          text: "In the last two weeks, have you worked or volunteered in a healthcare facility or as a first responder? Healthcare facilities include a hospital, medical or dental clinic, long-term care facility, or nursing home.",
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " YES",
              value: minor.toString(),
            ),
            Reply(
              title: " NO",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
          text:
              'Thank you for this self assesment. This will give us heath related data of yours.',
          user: bot,
          quickReplies:
              QuickReplies(values: [Reply(title: 'click here', value: '0')])),
      ChatMessage(
        text: 'Wait a moment we are analyzinng your health status...',
        user: bot,
      ),
    ];
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        conversation.add(ChatMessage(
          text:
              'Hello There! The purpose of this Self-Assessment tool is to help you make decisions about seeking appropriate medical care.\nThis system is not intended for the diagnosis or treatment of disease, including COVID-19.',
          user: bot,

        ));
        conversation.add(ChatMessage(
          text:'During the assessment, you can refresh the page \nif you need to start again.',
          user: bot,
        ));
      });
      isLodding = false;
    }).whenComplete(
      () => Future.delayed(
        Duration(seconds: 1),
        () {
          setState(() {
            conversation.add(
              ChatMessage(
                text: "Are you fully vaccinated against COVID-19? \n(You are considered fully vaccinated 2 weeks after your second dose in a two-shot series like Pfizer-BioNTech or Moderna vaccines, or 2 weeks after a single-dose vaccine such as Johnson & Johnson’s Janssen vaccine.)",

                user: bot,
                quickReplies: QuickReplies(
                  keepIt: true,
                  values: [
                    Reply(
                      messageId: 'a',
                      title: 'YES',
                      value: 0.toString(),
                    ),
                    Reply(
                      messageId: 'a',
                      title: 'NO',
                      value: 0.toString(), // set weight to the answer
                    ),

                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  int index = 0;
  bool showResult = false;

  List<Reply> replys = [];

  final controller = ScrollController();
  double offset = 0;
  Color color;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return Material(

      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: controller,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[



            (isLodding)
            //LOADING
                ? Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                      child: SizedBox(
                        height: 40,

                          child: LoadingIndicator(
                              color: Color(0xFF1D8F58),
                              indicatorType: Indicator.ballPulseSync))),
                )
                : SizedBox(
                    height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 28,
                      )),
                  IconButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget)),
                      icon: const Icon(
                        Icons.refresh,
                        color: Color(0xFF979797),
                        size: 28,
                      )),
                ],
              ),
                  ),

            (!showResult)
                ? DashChat(

                    height: 1000,
                    //QUESTIONS

                    messageBuilder: (r) => Container(

                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFF1D8F58),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.35),
                            )
                          ]),
                      child: Text(r.text,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'fedroka')),
                    ),
                    //QUICKREPLY
                    readOnly: true,
                    quickReplyPadding: EdgeInsets.only(left: 50),
                    quickReplyBuilder: (r) => Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF1D8F58),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                            )
                          ]),
                      child: Text(r.title,
                          style: TextStyle(
                              color: Color(0xFF1D8F58), fontFamily: 'fedroka')),
                    ),
                    //RESULT
                    onQuickReply: (reply) {
                      sum += double.parse(reply.value);

                      if (!replys.contains(reply)) {
                        replys.add(reply);

                        setState(() {
                          isLodding = true;
                        });
                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            conversation.clear();
                            conversation.add(chats[index]);
                            index++;
                            print(index);
                          });
                        }).then((value) {
                          setState(() {
                            isLodding = false;
                          });
                        });

                        if (index == 9) {
                          setState(() {
                            isLodding = true;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              if (sum < 0.7) {
                                result =
                                    "You are safe, \nSTAY HOME\nSTAY SAFE ";
                                color = Color(0xff185d4e);
                              } else if (sum >= 0.70 && sum <= 0.85) {
                                result =
                                    "Based on the answers given, \nyou should get tested 3-5 days after exposure and wear a mask in public indoor settings.";
                                color = Color(0xffff8c00);
                              } else {
                                result =
                                    "You have might chance to be COVID postive, Please call the covid help line number for further treatment";
                                color = Color(0xffff2d55);
                              }
                              isLodding = true;
                              showResult = true;
                            });
                          }).whenComplete(() {
                            setState(() {
                              isLodding = false;
                            });
                          });
                          print(result);
                        }
                      }
                      print(replys);
                      print(sum);
                    },
                    inputDisabled: true,
                    shouldStartMessagesFromTop: true,
                    alwaysShowSend: false,
                    shouldShowLoadEarlier: false,
                    inputTextStyle: TextStyle(color: Colors.black),
                    messages: conversation,
                    user: user,
                    onSend: null,

                  )
            //OUTPUT

                : Center(
                    child: Text(

                      result,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontFamily: 'fedroka',
                        fontSize: 28,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}



