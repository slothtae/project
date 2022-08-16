import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'new_password.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({Key?key}):super(key:key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();

}


class _ForgotPasswordState extends State<ForgotPassword>{
  bool _visible = true;
  bool _enable = true;
  final _phoneNumber = TextEditingController();
  late String _number;
  void showVerify(){
    setState((){
      _visible = !_visible;
      _enable = !_enable;
    });
  }
  void showAlert(Text _title,Text _content){
    showDialog<String>(
      context:context,
      builder:(BuildContext context)=>AlertDialog(
	title: _title,
	content: _content,
 	  actions:<Widget>[
	    TextButton(
	      onPressed: () => Navigator.pop(context,'Ok'),
	      child: const Text("Ok"),		    
	    ),
	  ],			
      ),		      
    );
  }
  @override	
  Widget build(BuildContext context){
    return Scaffold(
      body :Container(
        height: MediaQuery.of(context).size.height,
	width: MediaQuery.of(context).size.width,
	decoration: const BoxDecoration(
	  gradient: LinearGradient(
	    begin:Alignment.centerRight,
	    end:Alignment.bottomLeft,
	    colors:[
	      Color(0xFFEF9A94), // a gradient touch to the screen background
	      Color(0xFFFFEBEE),
	    ],	    
	  ),
	),
	child:Padding(
	  padding: EdgeInsets.only(top:100,right:40,left:40,bottom :100),
  	  child:Column(
	    //mainAxisAlignment: MainAxisAlignment.center, // so that they stay in mid of screen
	    crossAxisAlignment: CrossAxisAlignment.start, // just so the child are aligned to left
	    children: [ 
	      Padding(
	        padding:EdgeInsets.zero,
		child: Text(
		  'Forgot Password',
		  style:TextStyle(
		    fontFamily: 'Playfair Display',
  		    fontSize: 27,
		    fontWeight: FontWeight.bold,		    
		  ),
		),
	      ),
	      SizedBox(
		height: 80,		      
	      ),
	      Container(
		padding: const EdgeInsets.symmetric(vertical:1),
		decoration: BoxDecoration(
                   color: Colors.red.shade50,
                   borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
		  controller: _phoneNumber,
		  enabled:_enable,
		  keyboardType: TextInputType.number,
		  // TODO: delete the input Formatter if the final apk is not working
		  inputFormatters: <TextInputFormatter>[
			  FilteringTextInputFormatter.digitsOnly,
			  LengthLimitingTextInputFormatter(10),
		  ],
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
                ),
	      ),
	      SizedBox(
		height: 40,		     
	      ),
	      Visibility(
	        visible: _visible ,
	        child: SizedBox(
                height: 49, 
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: (){
	            _number = _phoneNumber.text;
                    showVerify();
		    showAlert(Text("OTP Sent"),Text("OTP has been sent to +91 $_number"));
		   
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4A148B)),
    	            shape: MaterialStateProperty
                          .all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                            ),
                          ),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17, 
                      fontFamily: "PlayFair Display",
                      ),
                    ),  
                  ),  
                ),

	      ),
	      Visibility(
		visible: !_visible,
		child:Column(
		  children:[Container(
		  padding: const EdgeInsets.symmetric(vertical:1),
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
                        hintText: "Otp",
                        hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 16,
                        fontWeight: FontWeight.w400,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                      ),
                    ),
	          ),
	          SizedBox(
	 	    height: 40,		     
	          ),
	          SizedBox(
                  height: 50, 
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (){
		      Navigator.push(
		        context,
		        MaterialPageRoute(builder:(context)=> NewPassword()),
		      );
		    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4A148C)),
    	              shape: MaterialStateProperty
                          .all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                            ),
                          ),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, 
                        fontFamily: "PlayFair Display",
                      ),
                    ),  
                  ),  
                ),		
		],
		),
	     ),
	    ],
	  ),	  
	),	
      ),		    
    );
  }
}
