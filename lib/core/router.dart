import 'package:floor_calculator/pages/calculators/concrete_calculator_page.dart';
import 'package:floor_calculator/pages/calculators/floor_calculator_page.dart';
import 'package:floor_calculator/pages/calculators/mortar_calculator_page.dart';
import 'package:floor_calculator/pages/calculators/paint_calculator_page.dart';
import 'package:floor_calculator/pages/calculators/stairs_calculator_page.dart';
import 'package:floor_calculator/pages/home_page.dart';
import 'package:floor_calculator/pages/result_page.dart';
import 'package:floor_calculator/pages/tools/compass_tool_page.dart';
import 'package:floor_calculator/pages/tools/flashlight_tool_page.dart';
import 'package:floor_calculator/pages/tools/level_tool_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/calculator/floor',
      name: 'floor',
      builder: (context, state) => const FloorCalculatorPage(),
    ),
    GoRoute(
      path: '/calculator/paint',
      name: 'paint',
      builder: (context, state) => const PaintCalculatorPage(),
    ),
    GoRoute(
      path: '/calculator/mortar',
      name: 'mortar',
      builder: (context, state) => const MortarCalculatorPage(),
    ),
    GoRoute(
      path: '/calculator/concrete',
      name: 'concrete',
      builder: (context, state) => const ConcreteCalculatorPage(),
    ),
    GoRoute(
      path: '/calculator/stairs',
      name: 'stairs',
      builder: (context, state) => const StairsCalculatorPage(),
    ),
    GoRoute(
      path: '/result',
      name: 'result',
      builder: (context, state) => const ResultPage(),
    ),
    GoRoute(
      path: '/tools/level',
      name: 'level',
      builder: (context, state) => const LevelToolPage(),
    ),
    GoRoute(
      path: '/tools/compass',
      name: 'compass',
      builder: (context, state) => const CompassToolPage(),
    ),
    GoRoute(
      path: '/tools/flashlight',
      name: 'flashlight',
      builder: (context, state) => const FlashlightToolPage(),
    ),
  ],
);
