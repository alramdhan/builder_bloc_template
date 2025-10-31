import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;
  late final Animation<Offset> _animationOffset;
  bool _isRemember = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this
    );
    _animationOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn
    ));

    Future.delayed(const Duration(seconds: 2), () {
      _animationController.forward();
      print("animateion status ${_animationController.status}");
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future _doLogin() async {

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.primary,
              AppColor.primary400
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _animationOffset,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: size.width - 45,
                          height: size.height * .734
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: SizedBox(
                          width: size.width,
                          height: size.height * .72,
                          child: _buildFormLogin()
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFormLogin() => Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Login"),
          CustomTFField(
            controller: _emailController,
            hintText: "Email",
          ),
          const SizedBox(height: 16),
          CustomTFField(
            controller: _pwdController,
            hintText: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 10),
          _buildRememberMe(),
          const SizedBox(height: 10),
          _buildButtonLogin(),
        ],
      ),
    ),
  );

  void onChanged(bool? value) {
    print("value $value");
    setState(() {
      _isRemember = value!;
    });
  }

  Widget _buildRememberMe() {
    // return CustomCBWidget(
    //   text: "Remember Me",
    //   onChanged: onChanged,
    //   value: isRemember,
    // );
    return CheckboxListTile(
      value: _isRemember,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Remember me"),
        ],
      ),
      
      
    );
  }

  Widget _buildButtonLogin() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: _doLogin,
        child: const Text("Log In",
          // style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //   color: AppColor.light,
          //   letterSpacing: 1.25
          // ),
        )
      ),
    );
  }
}