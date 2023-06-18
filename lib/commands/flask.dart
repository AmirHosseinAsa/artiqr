import 'package:artiqr/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:process_run/cmd_run.dart';


Future<void> shutdownServer() async {
  try {
    await http.head(Uri.parse('http://127.0.0.1:$portServ/shutdown'));
  } catch (e) {
    print(e);
  }
}

Future<bool> checkWebsiteStatus() async {
  try {
    final response =
        await http.head(Uri.parse('http://127.0.0.1:$portServ/status'));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<void> startServer() async {
  try {
    runCmd(ProcessCmd('python -m flask run -p $portServ', [],
        workingDirectory: 'python'));
  } catch (e) {
    print('Failed to start server: $e');
  }
}