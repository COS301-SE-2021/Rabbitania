import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/screens/Login/googleAuthTest.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';

@immutable
class ExampleExpandableFab extends StatelessWidget {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  const ExampleExpandableFab({Key? key}) : super(key: key);

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 112.0,
      children: [
        ActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoticeBoard()));
          },
          icon: const FaIcon(FontAwesomeIcons.home,
              color: Color.fromRGBO(171, 255, 79, 1)),
        ),
        ActionButton(
          onPressed: () => _showAction(context, 1),
          icon: const FaIcon(FontAwesomeIcons.bell,
              color: Color.fromRGBO(171, 255, 79, 1)),
        ),
        ActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          icon: const FaIcon(FontAwesomeIcons.userCircle,
              color: Color.fromRGBO(171, 255, 79, 1)),
        ),
      ],
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Container(
              color: Color.fromRGBO(33, 33, 33, 1),
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(FontAwesomeIcons.timesCircle,
                  color: Color.fromRGBO(171, 255, 79, 1)),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color.fromRGBO(33, 33, 33, 1),
              borderRadius: BorderRadius.circular(300),
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: Color.fromRGBO(171, 255, 79, 1),
              ),
              onPressed: _toggle,
            ),
          ),
        ),
      ),
    );
  }

  static const String _svg_rabbit =
      '<svg viewBox="133.2 106.0 97.5 124.8" ><path  d="M 212.2950134277344 223.7738189697266 L 192.08642578125 171.1501159667969 L 215.4000396728516 166.3672790527344 L 212.2950134277344 223.7738189697266 Z M 196.6366271972656 220.9618988037109 L 186.9429779052734 196.8519897460938 C 186.6976623535156 196.2409057617188 185.9737091064453 195.9319000244141 185.3284606933594 196.1663818359375 C 184.6831970214844 196.398681640625 184.3594055175781 197.0840759277344 184.6044921875 197.6951446533203 L 196.9864196777344 228.4840850830078 L 160.6315765380859 228.4821166992188 L 150.1785278320313 198.4012298583984 L 174.220703125 173.4614410400391 L 189.5909881591797 171.5763854980469 L 206.8825378417969 216.6077270507813 L 196.6366271972656 220.9618988037109 Z M 150.5927429199219 207.1684265136719 L 157.3074645996094 226.4887542724609 L 137.022705078125 212.2217254638672 L 150.5927429199219 207.1684265136719 Z M 201.1417083740234 136.9087677001953 L 214.9211578369141 164.0426330566406 L 191.1123199462891 168.9266052246094 L 184.8737182617188 157.0227661132813 L 201.1417083740234 136.9087677001953 Z M 166.610595703125 128.24072265625 L 169.8180236816406 114.0863571166992 L 174.6754302978516 117.4777374267578 C 174.6993713378906 117.4934310913086 174.7205352783203 117.5115203857422 174.7444610595703 117.5250244140625 L 199.6201477050781 134.8948974609375 L 186.7572631835938 150.7968139648438 L 166.610595703125 128.24072265625 Z M 179.5687255859375 109.6035995483398 L 195.0460205078125 128.7593841552734 L 176.9589233398438 116.1294250488281 L 179.5687255859375 109.6035995483398 Z M 217.3358154296875 163.3300170898438 L 203.8944244384766 136.8682250976563 L 228.2010040283203 145.9263610839844 L 228.2010040283203 158.7164916992188 L 217.3358154296875 163.3300170898438 Z M 230.6653900146484 159.6588134765625 C 230.6748199462891 159.6001892089844 230.7033538818359 159.546142578125 230.7033538818359 159.4851379394531 L 230.7033538818359 145.3647766113281 C 230.7033538818359 145.3196563720703 230.6794128417969 145.2791137695313 230.6748046875 145.2361907958984 C 230.72705078125 144.7197113037109 230.4391784667969 144.2191314697266 229.9080505371094 144.0184173583984 L 202.1632080078125 133.6795196533203 L 180.1854553222656 106.4759140014648 C 179.91162109375 106.1331176757813 179.4566650390625 105.9572448730469 179.0113830566406 106.0226211547852 C 178.5637817382813 106.085823059082 178.1852416992188 106.3743591308594 178.0232391357422 106.7757797241211 L 174.8634338378906 114.6725845336914 L 169.7416381835938 111.0918273925781 C 169.4012756347656 110.8551559448242 168.951171875 110.8008880615234 168.5558166503906 110.9362258911133 C 168.1607055664063 111.0804901123047 167.8654479980469 111.4030227661133 167.7773132324219 111.7976913452148 L 164.0341644287109 128.3128509521484 C 163.9531555175781 128.6737365722656 164.0532531738281 129.0457458496094 164.3031768798828 129.3253479003906 L 185.2000427246094 152.7250366210938 L 182.4118957519531 156.1706848144531 C 182.123779296875 156.5269927978516 182.0736083984375 157.0118713378906 182.2855529785156 157.4176483154297 L 188.5241546630859 169.3214721679688 L 173.4445190429688 171.1727600097656 C 173.1515808105469 171.20654296875 172.8802642822266 171.3418731689453 172.6800537109375 171.5493469238281 L 147.8354339599609 197.3187866210938 C 147.53076171875 197.6321411132813 147.4329528808594 198.0808715820313 147.5733337402344 198.4868621826172 L 149.8091888427734 204.9202880859375 L 134.0104217529297 210.80126953125 C 133.5865325927734 210.9590454101563 133.2864532470703 211.3221130371094 133.2293853759766 211.7462005615234 C 133.16748046875 212.1746368408203 133.3580322265625 212.5963287353516 133.7197723388672 212.853271484375 L 158.9811401367188 230.6199798583984 C 158.9836730957031 230.6221618652344 158.98828125 230.6245574951172 158.98828125 230.6267395019531 C 159.0978088378906 230.6988830566406 159.2144775390625 230.7553253173828 159.3382873535156 230.7958526611328 C 159.4644012451172 230.8363800048828 159.5953369140625 230.8544769287109 159.7262725830078 230.8544769287109 L 198.8006896972656 230.8566589355469 C 199.2126007080078 230.8566589355469 199.5959777832031 230.6648712158203 199.8293151855469 230.3425598144531 C 200.0649719238281 230.0224304199219 200.1151428222656 229.6142578125 199.9696960449219 229.2511901855469 L 197.5267333984375 223.1808319091797 L 207.7369842529297 218.8445129394531 L 212.0492248535156 230.0740814208984 C 212.2326354980469 230.5476226806641 212.7064514160156 230.8542633056641 213.2256164550781 230.8542633056641 C 213.2852172851563 230.8542633056641 213.3471221923828 230.8496856689453 213.4113159179688 230.8407440185547 C 213.9972229003906 230.7550964355469 214.4422760009766 230.2928771972656 214.4733276367188 229.7290954589844 L 217.9426422119141 165.6683654785156 L 229.9340515136719 160.5789031982422 C 229.9363555908203 160.5789031982422 229.9386596679688 160.5767211914063 229.9411926269531 160.5743255615234 L 229.9625854492188 160.5653991699219 C 230.0079345703125 160.5473022460938 230.0389862060547 160.5113525390625 230.0792694091797 160.4865112304688 C 230.1768493652344 160.4324645996094 230.2721099853516 160.3805847167969 230.3482818603516 160.3060607910156 C 230.4007568359375 160.2541961669922 230.4318084716797 160.1888122558594 230.4720916748047 160.1280212402344 C 230.5197143554688 160.0626525878906 230.5744934082031 160.0018310546875 230.6055603027344 159.9273071289063 C 230.6437530517578 159.8370819091797 230.6508941650391 159.7490386962891 230.6653900146484 159.6588134765625" fill="#abff4f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Color.fromRGBO(33, 33, 33, 1),
      elevation: 4.0,
      child: IconTheme.merge(
        data: theme.accentIconTheme,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
