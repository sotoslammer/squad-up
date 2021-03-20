import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final Function action;

  final IconData actionIcon;

  final String actionText;

  final String statusText;

  const ErrorState({
    Key key,
    this.action,
    this.actionIcon,
    this.actionText,
    this.statusText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                this.actionIcon ?? Icons.sentiment_dissatisfied,
              ),
              Text(
                statusText ?? 'An unexpected error has occurred',
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: action != null,
                child: OutlinedButton(
                  onPressed: action,
                  child: Text(actionText ?? 'Tap to retry.'),
                ),
              )
            ]));
  }
}