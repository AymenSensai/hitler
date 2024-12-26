import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';
import '../utils/spacing.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? networkCall;
  final bool showNoInternerWidget;

  const ConnectivityWrapper({
    required this.child,
    super.key,
    this.networkCall,
    this.showNoInternerWidget = true,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.wifi];
  ConnectivityResult? _lastConnectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      if (widget.networkCall != null &&
          _lastConnectionStatus == ConnectivityResult.none &&
          _connectionStatus.last == ConnectivityResult.wifi) {
        widget.networkCall!();
      }
      _lastConnectionStatus = result.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (_connectionStatus.last == ConnectivityResult.none) {
          return widget.showNoInternerWidget
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 100.h,
                        color: Colors.grey,
                      ),
                      verticalSpace(24),
                      Text(
                        'أنت غير متصل بالإنترنت',
                        style: TextStyles.font18BlackSemiBold,
                      ),
                      verticalSpace(24),
                      Text(
                        'لا يوجد اتصال بالإنترنت',
                        style: TextStyles.font14BlackMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        } else {
          return widget.child;
        }
      },
    );
  }
}
