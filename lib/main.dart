import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:number_to_text_converter/common/core/di/injection_container.dart';
import 'package:number_to_text_converter/feature/domain/presentation/bloc/convert_bloc.dart';
import 'common/core/di/environment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(environment: dev.name);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ConvertBloc>(),
      child: MaterialApp(
        title: 'Number-To-Text-Converter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Converter Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConvertBloc, ConvertState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Enter the number to convert:"),
                const Gap(12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter Number",
                  ),
                  controller: textController,
                ),
                const Gap(12),
                ElevatedButton(
                  onPressed: () {
                    debugPrint("CLICKED");
                    context
                        .read<ConvertBloc>()
                        .add(ConvertEvent.convertToText(textController.text));
                  },
                  child: const Text("Convert"),
                ),
                const Gap(12),
                Flexible(
                  child: Text(state.textResult ?? ""),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
