import 'dart:io';

import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:builder_bloc_template/presentation/views/auth/cubit/rememberme_cubit.dart';
import 'package:builder_bloc_template/presentation/views/auth/register_page.dart';
import 'package:builder_bloc_template/presentation/views/home/menu_tab.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/check_box.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider(create: (_) => sl<RemembermeCubit>()),
      ],
      // create: (_) => sl<AuthBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;
  late final AnimationController _animRegisController;
  late final Animation<Offset> _animationOffset;
  late final Animation<Offset> _animRegisOffset;
  // bool _isRemember = false;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    );
    _animRegisController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this
    );
    _animationOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutExpo
    ));
    _animRegisOffset = Tween<Offset>(
      begin: const Offset(0, -3),
      end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _animRegisController,
      curve: Curves.easeInOutBack
    ));

    Future.delayed(const Duration(milliseconds: 1200), () {
      _animationController.forward();
      _animationController.addListener(() {
        setState(() {});
        if(_animationOffset.isCompleted) {
          _animRegisController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animRegisController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  Future _doLogin() async {
    if(_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SigninSubmitted(email: _emailController.text, password: _pwdController.text)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is SigninFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error.message))
              );
          }

          if(state is SigninSuccess) {
            sl<AppRouter>().pushReplacement(const MainMenuTab());
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColor.primary,
                  AppColor.primary400
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.paddingOf(context).top,
                  left: 0,
                  right: 0,
                  child: _buildRegisterContent()
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top + (Platform.isIOS ? 64 : 84),
                  left: 0,
                  right: 0,
                  child: _buildLogoApp(),
                ),
                _buildCardForm(size, state)
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildRegisterContent() => SlideTransition(
    position: _animRegisOffset,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: Platform.isIOS ? 0 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Doesn't have an account?",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.light
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColor.secondary)
            ),
            onPressed: () {
              sl<AppRouter>().push(const RegisterPage());
            },
            child: const Text('Sign Up',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.light
              ),
            )
          )
        ],
      ),
    ),
  );

  Widget _buildLogoApp() {
    return AnimatedOpacity(
      opacity: _animationOffset.isCompleted ? 1 : 0,
      duration: const Duration(seconds: 1),
      child: const Center(
        child: FlutterLogo(size: 64),
      ),
    );
  }

  Widget _buildCardForm(Size size, AuthState state) {
    return Positioned(
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
                color: Colors.white38,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.height * .74,
                  child: _buildFormLogin(state)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormLogin(AuthState state) {
    const Widget line = Expanded(child: Divider(color: AppColor.secondary));
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
                Text("Welcome Back",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700
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
            _buildButtonLogin(isLoading: state is SigninLoading),
            const SizedBox(height: 32),
            const Row(
              children: [
                line,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("atau masuk dengan",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
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

  Widget _buildRememberMe() {
    return BlocBuilder<RemembermeCubit, bool>(
      builder: (context, isChecked) {
        return CustomCBWidget(
          text: "Ingat Saya",
          onChanged: () {
            context.read<RemembermeCubit>().toggleRememberMe(!isChecked);
          },
          value: isChecked,
        );
      }
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

  Widget _buildButtonLogin({required bool isLoading}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: isLoading ? null : _doLogin,
        child: isLoading
          ? const SpinKitThreeInOut(
            size: 26,
            color: AppColor.primary
          ) : const Text("Masuk")
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(12),
            elevation: 16,
            shadowColor: Colors.black
          ),
          onPressed: () {},
          icon: Image.asset("assets/images/google.png",
            width: 32,
          )
        )
      ],
    );
  }
}