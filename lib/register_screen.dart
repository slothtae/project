import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
dynamic color1= 0xFFEF9A94;
class _RegisterScreenState extends State<RegisterScreen> {
  String dropdown_value="none";
  List<String> items=[
    "Volunteer",
    "Normal User",
    "None"
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
              gradient:LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors:[
                    Color(0xFFEF9A94),
                    Color(0xFFFFEBEE),
                  ]
              )
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top:100, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text(
                      'Create New Account',
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  const SizedBox(
                    height:30,
                  ),
                  Container(
                      padding:  const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                              fontWeight: FontWeight.w400,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                        ),
                      )
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  Container(
                      padding:  const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                              fontWeight: FontWeight.w400,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                        ),
                      )
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  Container(
                      padding:  const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                              fontWeight: FontWeight.w400,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                        ),
                      )
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  Container(
                      padding:  const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                              fontWeight: FontWeight.w400,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                        ),
                      )
                  ),
                  const SizedBox(
                    height:20,
                  ),
                Container(
                  padding:  const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                            fontWeight: FontWeight.w400,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                      ),
                        items: <String>["Normal User", "Volunteer"].map((String val){
                          return DropdownMenuItem<String>(
                              value:val,
                              child: Text(val),
                          );
                        }).toList(),
                        hint: const Text("Select the role",
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),),
                        onChanged: (_){},
                    ),
                  ),
                ),
                 const SizedBox(
                    height:40,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty
                              .all<Color>(Color(0xff4A148C)),
                          shape: MaterialStateProperty
                              .all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .circular(7)
                            ),
                          ),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "PlayFair Display",
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
      ),
          ),
          ),
    );

  }
}
