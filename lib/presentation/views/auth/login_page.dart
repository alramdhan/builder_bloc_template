import 'package:builder_bloc_template/core/config/error/failure.dart';
import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/check_box.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  String _email = '';
  String _password = '';

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
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  Future _doLogin() async {
    context.read<AuthBloc>().add(
      SigninSubmitted(email: _email, password: _password)
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is Failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Error"))
              );
          }
        },
        builder: (context, state) {
          return Container(
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
                  top: MediaQuery.sizeOf(context).height * .1,
                  left: 0,
                  right: 0,
                  child: _buildLogoApp(),
                ),
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
                              width: size.width - 40,
                              height: size.height * .75
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
                              height: size.height * .738,
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
          );
        }
      ),
    );
  }

  Widget _buildLogoApp() {
    return Column(
      children: [
        const FlutterLogo(size: 80),
        const SizedBox(height: 6),
        Text("Flutter Template Builder",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColor.light
          )
        )
      ],
    );
  }

  Widget _buildFormLogin() {
    final line = Expanded(child: Divider(color: Colors.blueGrey.shade300));
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("APP Title",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    
                  ),
                ),
                const Text("Welcome back, please enter your credential account.",
                  style: TextStyle(color: Colors.blueGrey),
                )
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 32),
            Row(
              children: [
                line,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("or sign in with"),
                ),
                line,
              ],
            ),
            // const Center(
            //   child: Text("or sign in with")
            // ),
            const SizedBox(height: 32),
            _buildSignInWith()
          ],
        ),
      ),
    );
  }

  void onChanged(bool? value) {
    print("value $value");
    setState(() {
      _isRemember = value!;
    });
  }

  Widget _buildRememberMe() {
    return CustomCBWidget(
      text: "Remember Me",
      onChanged: onChanged,
      value: _isRemember,
    );
    // return CheckboxListTile(
    //   value: _isRemember,
    //   onChanged: onChanged,
    //   contentPadding: EdgeInsets.zero,
    //   title: const Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       Text("Remember me"),
    //     ],
    //   ),
    // );
  }

  Widget _buildButtonLogin() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: _doLogin,
        child: const Text("Sign In")
      ),
    );
  }

  Widget _buildSignInWith() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            elevation: 16,
            shadowColor: Colors.black
          ),
          onPressed: () {},
          icon: Image.asset("assets/images/google.png",
            width: 48,
          )
        )
      ],
    );
  }
}