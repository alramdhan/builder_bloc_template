import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:builder_bloc_template/presentation/widgets/forms/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void _doRegister() {
    if(_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignupSubmitted(email: _emailController.text, password: _pwdController.text)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is FailureResponse) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("tttt"))
              );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTFField(
                  controller: _emailController,
                  hintText: "Email",
                ),
                CustomTFField(
                  controller: _pwdController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    onPressed: _doRegister,
                    child: state is SigninLoading
                      ? const SizedBox.square(
                        dimension: 26,
                        child: CircularProgressIndicator(
                          color: Colors.white
                        ),
                      ) : const Text("Sign Up")
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}