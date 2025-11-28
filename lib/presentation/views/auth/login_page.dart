import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:builder_bloc_template/presentation/views/auth/register_page.dart';
import 'package:builder_bloc_template/presentation/views/home/home_page.dart';
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

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  String? _email;
  String? _password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _animationController;
  late final AnimationController _animRegisController;
  late final Animation<Offset> _animationOffset;
  late final Animation<Offset> _animRegisOffset;
  bool _isRemember = false;
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
      curve: Curves.fastOutSlowIn
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
        print("animateion status ${_animationOffset.isCompleted}");
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
    logger.d("email $_email");
    logger.d("pwd $_password");
    if(_email != null || _password != null) {
      context.read<AuthBloc>().add(
        SigninSubmitted(email: _emailController.text, password: _pwdController.text)
      );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("Field harus diisi"))
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          logger.d("state $state");
          if(state is SigninFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error.message))
              );
          }

          if(state is SigninSuccess) {
            sl<AppRouter>().push(HomePage());
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
                  top: MediaQuery.paddingOf(context).top + 20,
                  left: 0,
                  right: 0,
                  child: _buildRegisterContent()
                ),
                Positioned(
                  top: size.height * .16,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Doesn't have an account?",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.secondary
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
      child: Center(
        child: Text("App Name",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColor.light
          )
        ),
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
    final line = Expanded(child: Divider(color: Colors.blueGrey.shade200));
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
              onChanged: (value) {
                _email = value;
              },
              hintText: "Email",
            ),
            const SizedBox(height: 16),
            CustomTFField(
              controller: _pwdController,
              hintText: "Password",
              onChanged: (value) {
                _password = value;
              },
              obscureText: true,
            ),
            const SizedBox(height: 10),
            _buildRememberMe(),
            const SizedBox(height: 10),
            _buildButtonLogin(state),
            const SizedBox(height: 32),
            Row(
              children: [
                line,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("or sign in with",
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

  Widget _buildButtonLogin(AuthState state) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: _doLogin,
        child: state is SigninLoading
          ? const SpinKitThreeInOut(
            size: 24,
            color: Colors.white
          ) : const Text("Sign In")
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