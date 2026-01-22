# Welcome Screen Animation Guide

## Overview

This guide explains how to implement the welcome screen animation where:
1. **Logo moves up** from center to top section (~35% from top)
2. **Bottom panel slides up** with curved top edge
3. **Text and buttons appear** in the bottom panel

---

## Animation Approaches

### **Approach 1: Stack + AnimatedPositioned (Recommended) ✅**

**Pros:**
- Simple and performant
- Easy to control logo position
- Good for layered layouts

**How it works:**
- Use `Stack` with `AnimatedPositioned` for logo
- Use `SlideTransition` for bottom panel
- Control animations with `AnimationController`

### **Approach 2: Hero Widget**

**Pros:**
- Smooth shared element transition between screens
- Built-in Flutter animation

**Cons:**
- Less control over exact timing
- More complex to coordinate with other animations

### **Approach 3: AnimatedContainer**

**Pros:**
- Simple position/size animations
- Automatic transitions

**Cons:**
- Less precise control
- Not ideal for complex animations

---

## Recommended Implementation: Stack + AnimatedPositioned + SlideTransition

### Animation Sequence:

```
1. Screen loads → Logo at center (50% from top)
2. After 300ms → Start animations:
   - Logo moves up to 35% from top (400ms)
   - Bottom panel slides up from bottom (500ms, with delay)
   - Text fades in (300ms, with delay)
   - Buttons fade in (300ms, after text)
```

### Key Components:

1. **Animation Controllers:**
   - `_logoPositionController` - Controls logo vertical position
   - `_panelSlideController` - Controls bottom panel slide
   - `_contentFadeController` - Controls text/buttons fade

2. **Layout Structure:**
   ```
   Stack
   ├── Top Section (beige background, logo)
   │   └── AnimatedPositioned (logo)
   └── Bottom Panel (white, curved top)
       ├── SlideTransition (panel)
       └── FadeTransition (content)
   ```

---

## Implementation Steps

### Step 1: Create Animation Controllers

```dart
late AnimationController _logoPositionController;
late AnimationController _panelSlideController;
late AnimationController _contentFadeController;

late Animation<Offset> _logoPositionAnimation;
late Animation<Offset> _panelSlideAnimation;
late Animation<double> _contentFadeAnimation;
```

### Step 2: Initialize Animations

```dart
@override
void initState() {
  super.initState();
  
  // Logo position animation (moves up)
  _logoPositionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  _logoPositionAnimation = Tween<Offset>(
    begin: const Offset(0, 0), // Center
    end: const Offset(0, -0.35), // Move up
  ).animate(CurvedAnimation(
    parent: _logoPositionController,
    curve: Curves.easeOut,
  ));
  
  // Panel slide animation
  _panelSlideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  _panelSlideAnimation = Tween<Offset>(
    begin: const Offset(0, 1), // Below screen
    end: Offset.zero, // Final position
  ).animate(CurvedAnimation(
    parent: _panelSlideController,
    curve: Curves.easeOutCubic,
  ));
  
  // Content fade animation
  _contentFadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  _contentFadeAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _contentFadeController,
    curve: Curves.easeIn,
  ));
  
  // Start animations
  _startAnimations();
}

void _startAnimations() {
  // Wait a bit, then start logo movement
  Future.delayed(const Duration(milliseconds: 300), () {
    _logoPositionController.forward();
  });
  
  // Start panel slide after logo starts moving
  Future.delayed(const Duration(milliseconds: 500), () {
    _panelSlideController.forward();
  });
  
  // Fade in content after panel starts sliding
  Future.delayed(const Duration(milliseconds: 700), () {
    _contentFadeController.forward();
  });
}
```

### Step 3: Build Layout

```dart
@override
Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Scaffold(
    backgroundColor: AppColors.scaffoldBackgroundSplash,
    body: Stack(
      children: [
        // Top section with logo (beige background)
        _buildTopSection(screenHeight),
        
        // Bottom panel (white, curved top)
        _buildBottomPanel(screenHeight),
      ],
    ),
  );
}
```

### Step 4: Logo Animation (Top Section)

```dart
Widget _buildTopSection(double screenHeight) {
  return Container(
    height: screenHeight * 0.6, // 60% of screen
    color: AppColors.scaffoldBackgroundSplash,
    child: Center(
      child: SlideTransition(
        position: _logoPositionAnimation,
        child: Image.asset(
          AssetConstants.logo,
          width: 120,
          height: 120,
        ),
      ),
    ),
  );
}
```

### Step 5: Bottom Panel with Curved Top

```dart
Widget _buildBottomPanel(double screenHeight) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    height: screenHeight * 0.5, // 50% of screen
    child: SlideTransition(
      position: _panelSlideAnimation,
      child: ClipPath(
        clipper: CurvedTopClipper(), // Custom clipper for curved top
        child: Container(
          color: AppColors.white,
          child: FadeTransition(
            opacity: _contentFadeAnimation,
            child: _buildPanelContent(),
          ),
        ),
      ),
    ),
  );
}
```

### Step 6: Custom Clipper for Curved Top

```dart
class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = 30.0;
    
    path.moveTo(0, curveHeight);
    
    // Create smooth curve
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      curveHeight,
    );
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
```

---

## Alternative: Simpler Approach (Using Transform)

If you want a simpler implementation without custom clippers:

```dart
// Logo position using Transform.translate
Transform.translate(
  offset: Offset(0, -MediaQuery.of(context).size.height * 0.15 * _logoAnimation.value),
  child: Image.asset(AssetConstants.logo),
)

// Bottom panel using Transform.translate
Transform.translate(
  offset: Offset(0, MediaQuery.of(context).size.height * 0.5 * (1 - _panelAnimation.value)),
  child: Container(...),
)
```

---

## Complete Example Structure

```dart
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _logoController;
  late AnimationController _panelController;
  late AnimationController _contentController;
  
  // Animations
  late Animation<double> _logoPosition;
  late Animation<Offset> _panelSlide;
  late Animation<double> _contentFade;
  
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }
  
  void _setupAnimations() {
    // Initialize controllers and animations
    // ... (see Step 2 above)
  }
  
  void _startAnimations() {
    // Start animation sequence
    // ... (see Step 2 above)
  }
  
  @override
  Widget build(BuildContext context) {
    // Build UI with animations
    // ... (see Steps 3-5 above)
  }
  
  @override
  void dispose() {
    _logoController.dispose();
    _panelController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
```

---

## Tips for Best Results

1. **Timing**: Stagger animations slightly (50-100ms delays) for smoother feel
2. **Curves**: Use `Curves.easeOut` for natural motion
3. **Performance**: Use `RepaintBoundary` if animations are complex
4. **Responsive**: Use percentages of screen height for responsive design
5. **Testing**: Test on different screen sizes

---

## Next Steps

1. Implement the welcome screen with animations
2. Test animation timing and smoothness
3. Adjust curves and durations based on design requirements
4. Add Hero widget for logo transition from splash (optional)

