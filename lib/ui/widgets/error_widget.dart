import 'package:dailydose/utils/app_exception.dart';
import 'package:flutter/Material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key, required this.exceptionCaught, this.onPressed});
  final CustomException? exceptionCaught;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final exception = exceptionCaught ?? CustomException();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            exception.icon,
            size: 42,
            color: exception.color,
          ),
          Text(
            exception.title ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            exception.message ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (onPressed != null) ...[
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  backgroundColor: Theme.of(context).colorScheme.surface),
              onPressed: onPressed,
              child: const Text("Retry"),
            ),
          ]
        ],
      ),
    );
  }
}
