
import 'package:flutter/material.dart';
import 'package:mostafa1/shared/components/components.dart';
class Login extends StatefulWidget {
    Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();

  var passwordController=TextEditingController();

  var formkay = GlobalKey<FormState>();

   bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form (
              key: formkay,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0
                      ),
                ),
                   SizedBox(
                    height: 20.0,
                  ),

                  defultformfield(
                    keyboard: TextInputType.emailAddress,
                    label: 'email',
                    controle: emailController,
                    prefix: Icons.email_outlined,

                    validate: ( value)  {
                      if (value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                      return null;
                    },


                  ),
                   SizedBox(
                    height: 20.0,
                  ),
                  defultformfield(
                    label: 'password',
                    validate: ( value)  {
                      if (value.isEmpty)
                      {
                        return 'password must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.lock_open,
                    suffix: isPassword ? Icons.visibility_off_outlined : Icons.remove_red_eye,
                    isPassword: isPassword,
                    keyboard: TextInputType.visiblePassword,
                       controle: passwordController,
                    suffixPressed: (){
                    setState(() {

                    });
                      isPassword = !isPassword ;
                    },

                  ),

                   SizedBox(
                    height: 30.0,
                  ),
                  defultButton(
                     backGround: Colors.blue,
                    text: 'lOGIN',
                    width: double.infinity,
                    function: () {
                      if (formkay.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    }
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        'don\'t have an account?',
                      ),
                      TextButton(onPressed: (){},
                          child: Text(
                            'Register now'
                          ),
                      )
                    ],

                  ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}