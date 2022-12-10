import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/views/screens/screens.dart';

var sessionProvider = StateProvider<bool>((ref) {
  bool isUserRegistered = false;
  return isUserRegistered;
});

class SessionHandler extends ConsumerWidget {
  const SessionHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isUserLogged = ref.watch(sessionProvider);
    return isUserLogged ? const MyHome() : const Tours01();
  }
}
