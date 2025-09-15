# UI Development Rules - Next.js Stack

## Overview
Comprehensive UI development standards for modern Next.js applications with mobile-first design philosophy, type safety, and exceptional user experience.

## Core Technology Stack

### Framework & Runtime
- **Next.js 14+** (App Router) - Full-stack React framework
- **React 18+** - Component library with concurrent features
- **TypeScript 5+** - Strict type checking

### Styling & Components
- **Tailwind CSS v3+** - Utility-first CSS framework
- **Shadcn/UI** - Copy-paste component library built on Radix
- **Radix UI** - Low-level accessible primitives
- **Class Variance Authority (CVA)** - Component variant management
- **Tailwind Merge** - Conditional class merging

### Validation & Forms
- **Zod** - TypeScript-first schema validation
- **React Hook Form** - Performant forms with minimal re-renders
- **@hookform/resolvers** - Zod integration for forms

### Icons & Assets
- **Lucide React** - Beautiful & consistent icon library
- **Next.js Image** - Optimized image component
- **@next/font** - Font optimization

### Animation & Interaction
- **Framer Motion** - Production-ready motion library
- **Lottie React** - After Effects animations (when needed)

### Development & Testing
- **Storybook** - Component development environment
- **Vitest** - Fast unit testing
- **Testing Library** - Simple and complete testing utilities
- **Playwright** - End-to-end testing

## Mobile-First Design Philosophy

### Core Principles
1. **Design for mobile first, enhance for desktop**
2. **Touch-friendly interfaces** (44px minimum touch targets)
3. **Progressive disclosure** of information
4. **Thumb-friendly navigation zones**
5. **Readable typography** without zooming

### Responsive Breakpoints
```typescript
// Tailwind breakpoints (mobile-first)
const breakpoints = {
  sm: '640px',   // Small tablets
  md: '768px',   // Tablets
  lg: '1024px',  // Small laptops
  xl: '1280px',  // Desktops
  '2xl': '1536px' // Large screens
}
```

### Design Tokens
```typescript
// Base spacing scale (4px grid)
const spacing = {
  xs: '4px',    // 1
  sm: '8px',    // 2
  md: '16px',   // 4
  lg: '24px',   // 6
  xl: '32px',   // 8
  '2xl': '48px' // 12
}

// Typography scale
const typography = {
  xs: '12px',   // Caption
  sm: '14px',   // Body small
  base: '16px', // Body
  lg: '18px',   // Body large
  xl: '20px',   // H4
  '2xl': '24px', // H3
  '3xl': '30px', // H2
  '4xl': '36px'  // H1
}
```

## Component Architecture

### Component Categories

#### 1. Layout Components
- **Container**: Max-width responsive containers
- **Grid**: CSS Grid wrapper with responsive columns
- **Flex**: Flexbox utilities with gap support
- **Stack**: Vertical/horizontal spacing utilities
- **Section**: Semantic page sections with proper spacing

#### 2. Navigation Components
- **BottomNavigation**: Mobile-first tab navigation
- **TopNavigation**: Desktop header navigation
- **Drawer**: Slide-out navigation panel
- **Breadcrumb**: Hierarchical navigation trail
- **Pagination**: Page navigation with mobile considerations

#### 3. Input Components
- **Input**: Text input with validation states
- **Select**: Dropdown with search and multi-select
- **Checkbox**: Single and group selections
- **RadioGroup**: Mutually exclusive options
- **Switch**: Boolean toggle control
- **Slider**: Range input for numeric values
- **DatePicker**: Calendar input with mobile optimization
- **SearchInput**: Search with autocomplete

#### 4. Data Display Components
- **Card**: Content container with variants
- **Table**: Responsive data tables with mobile stacking
- **List**: Ordered/unordered lists with actions
- **Badge**: Status and categorical labels
- **Avatar**: User profile images with fallbacks
- **Skeleton**: Loading state placeholders
- **EmptyState**: No data illustrations and actions

#### 5. Feedback Components
- **Toast**: Temporary notification messages
- **Alert**: Persistent informational messages
- **Modal**: Overlay dialogs with proper focus management
- **Popover**: Contextual information overlays
- **Tooltip**: Hover/focus information (desktop only)
- **Progress**: Task completion indicators
- **Spinner**: Loading indicators

#### 6. Media Components
- **Image**: Optimized images with lazy loading
- **Video**: Responsive video player
- **ImageGallery**: Mobile-optimized image carousel
- **FileUpload**: Drag-and-drop file input

### Component Structure
```typescript
// Component file structure
components/
├── ui/                    // Base UI components (shadcn)
│   ├── button.tsx
│   ├── input.tsx
│   └── card.tsx
├── layout/               // Layout components
│   ├── container.tsx
│   ├── grid.tsx
│   └── stack.tsx
├── navigation/           // Navigation components
│   ├── bottom-nav.tsx
│   ├── drawer.tsx
│   └── breadcrumb.tsx
├── forms/               // Form-specific components
│   ├── form-field.tsx
│   ├── search-input.tsx
│   └── file-upload.tsx
└── feedback/            // User feedback components
    ├── toast.tsx
    ├── modal.tsx
    └── loading.tsx
```

## Coding Standards

### Component Definition Standards
- **Function declarations only** - Use `function ComponentName()` instead of arrow functions for better debugging and hoisting
- **TypeScript interfaces** - Define props interface with explicit types, avoiding `any`
- **Default props** - Provide sensible defaults using parameter destructuring
- **Variant system** - Use Class Variance Authority (CVA) for component variations (primary, secondary, sizes)
- **Compound components** - Break complex components into smaller, reusable parts
- **Forward refs** - Enable ref forwarding for form integration and DOM manipulation
- **Accessibility props** - Include ARIA attributes and semantic HTML elements by default
- **Loading states** - Handle loading, disabled, and error states consistently
- **Custom className merging** - Allow style overrides while maintaining base styles using tailwind-merge
```

### Form Validation Standards
- **Schema-first validation** - Define Zod schemas for all form data with descriptive error messages
- **Type inference** - Use `z.infer<typeof schema>` to generate TypeScript types from schemas
- **Real-time validation** - Validate on blur, not on every keystroke to avoid interrupting user input
- **Complex validation** - Use `.refine()` for cross-field validation (password confirmation, date ranges)
- **Error message clarity** - Provide specific, actionable error messages that tell users how to fix issues
- **Form state management** - Use React Hook Form for performance and minimal re-renders
- **Field composition** - Create reusable FormField components that handle label, input, and error display
- **Accessibility integration** - Connect form labels, inputs, and error messages with proper ARIA attributes
- **Progressive enhancement** - Forms work without JavaScript, then enhanced with validation
- **Data persistence** - Preserve user input during validation errors and page refreshes
```

### Responsive Design Standards
- **Mobile-first approach** - Write base styles for mobile, then add larger screen enhancements with breakpoint prefixes
- **Logical breakpoint progression** - Use consistent scaling patterns (padding: 4 → 6 → 8, text: sm → base → lg)
- **Container system** - Implement responsive containers with appropriate max-widths and padding for each breakpoint
- **Flexible layouts** - Use CSS Grid and Flexbox for layouts that adapt naturally to screen sizes
- **Content-driven breakpoints** - Choose breakpoints based on when content becomes awkward, not device sizes
- **Touch-friendly spacing** - Ensure adequate spacing between interactive elements on mobile (44px minimum touch targets)
- **Readable line lengths** - Limit text width to 65-75 characters for optimal readability across devices
- **Scalable typography** - Use responsive font sizes that improve readability without requiring zoom
- **Progressive disclosure** - Show essential information on mobile, expand details on larger screens
```

## Accessibility Standards

### WCAG 2.1 AA Compliance
- **Color contrast**: 4.5:1 for normal text, 3:1 for large text
- **Focus management**: Visible focus indicators
- **Keyboard navigation**: Full keyboard accessibility
- **Screen reader support**: Proper ARIA labels and roles
- **Touch targets**: Minimum 44px for mobile

### Implementation Standards
- **Semantic HTML first** - Use proper HTML elements (button, nav, main, section) before adding ARIA
- **Descriptive labels** - Provide clear, contextual labels using aria-label or aria-labelledby
- **Error announcements** - Use role="alert" for dynamic error messages to notify screen readers
- **Focus management** - Maintain logical tab order and visible focus indicators throughout the application
- **Form associations** - Connect labels, inputs, and error messages using htmlFor, id, and aria-describedby
- **State communication** - Use aria-expanded, aria-pressed, and aria-selected to communicate component states
- **Loading states** - Announce loading states with aria-live regions or aria-busy attributes
- **Color independence** - Never rely solely on color to convey information; include text or icons
- **Keyboard navigation** - Ensure all interactive elements are reachable and operable via keyboard
- **Screen reader testing** - Test with actual screen readers (NVDA, JAWS, VoiceOver) not just automated tools
```

## Performance Guidelines

### Core Web Vitals Targets
- **LCP**: < 2.5s (Largest Contentful Paint)
- **FID**: < 100ms (First Input Delay)
- **CLS**: < 0.1 (Cumulative Layout Shift)

### Optimization Strategies
- **Image optimization** - Use Next.js Image component with proper sizing, lazy loading, and blur placeholders
- **Priority loading** - Mark above-the-fold images as priority to improve LCP scores
- **Component lazy loading** - Split large components using React.lazy() and Suspense with meaningful loading states
- **Dynamic imports** - Load heavy libraries only when needed using dynamic imports
- **Bundle analysis** - Regularly analyze bundle size and eliminate unused dependencies
- **Code splitting** - Split routes and components to reduce initial bundle size
- **Prefetching** - Use Next.js link prefetching for critical user journeys
- **Caching strategies** - Implement proper HTTP caching headers and service worker caching
- **Font optimization** - Use Next.js font optimization with proper font-display strategies
- **Third-party scripts** - Load analytics and tracking scripts using Next.js Script component with appropriate strategies
```

## Testing Standards

### Component Testing Standards
- **Behavior-driven tests** - Test user interactions and outcomes, not implementation details
- **Accessibility testing** - Use semantic queries (getByRole, getByLabelText) that match how users interact
- **User event simulation** - Use @testing-library/user-event for realistic user interactions
- **Async handling** - Properly handle async operations with waitFor and findBy queries
- **State testing** - Test all component states (loading, error, empty, success) with appropriate assertions
- **Props validation** - Test that props are correctly passed and handled by components
- **Mock strategies** - Mock external dependencies and API calls while keeping component logic testable
- **Snapshot testing** - Use sparingly, only for components with stable visual output
- **Integration testing** - Test component interactions within realistic user workflows
- **Error boundaries** - Test error states and boundary behavior with intentional error triggering
```

### Visual Regression Testing Standards
- **Storybook integration** - Create comprehensive stories for all component variants and states
- **Viewport testing** - Test components across mobile, tablet, and desktop viewports
- **State documentation** - Document all visual states (default, hover, focus, disabled, loading, error)
- **Dark mode coverage** - Test both light and dark theme variations for all components
- **Automated screenshots** - Use tools like Chromatic or Percy for automated visual diff detection
- **Cross-browser testing** - Test visual consistency across Chrome, Firefox, Safari, and Edge
- **Responsive breakpoints** - Verify visual integrity at common breakpoint transitions
- **Typography testing** - Test with various text lengths and internationalization scenarios
- **Color contrast validation** - Automated testing for WCAG AA compliance across all color combinations
- **Animation testing** - Test motion and transition states with reduced motion preferences
```

## Project Setup

### Installation Standards
- **Next.js foundation** - Start with latest Next.js using App Router, TypeScript, Tailwind, and ESLint
- **UI component system** - Install Radix UI primitives, Class Variance Authority, and utility libraries
- **Icon system** - Use Lucide React for consistent, tree-shakeable icons
- **Form handling** - Set up React Hook Form with Zod for validation and type safety
- **Animation framework** - Install Framer Motion for smooth, performant animations
- **Development tooling** - Configure Storybook for component development and documentation
- **Testing setup** - Install Vitest, Testing Library, and Playwright for comprehensive testing
- **Code quality** - Set up Prettier, ESLint, and Husky for consistent code formatting
- **Type checking** - Configure strict TypeScript settings for better development experience
- **Build optimization** - Set up bundle analyzer and performance monitoring tools

### Configuration Files

#### Configuration Standards
- **Tailwind configuration** - Extend default theme with custom screens, spacing, and colors as needed
- **Content scanning** - Include all relevant file paths for Tailwind class detection
- **Plugin integration** - Add essential plugins like forms and typography for enhanced functionality
- **Custom utilities** - Create project-specific utility classes for common patterns
- **TypeScript configuration** - Use strict mode with proper path mapping and Next.js integration
- **Module resolution** - Configure bundler-based resolution for modern import patterns
- **Path aliases** - Set up clean import paths (@/components, @/lib, @/types) for better organization
- **Library targeting** - Target appropriate ES version and DOM APIs for project requirements
- **Incremental compilation** - Enable for faster development builds and type checking
- **Next.js integration** - Use Next.js TypeScript plugin for enhanced development experience
```

## File Organization Standards
- **App directory structure** - Use Next.js App Router with clear separation of routes and layouts
- **Component categorization** - Organize components by purpose (ui, layout, forms, navigation)
- **Utility libraries** - Centralize utilities, validations, and constants in lib directory
- **Custom hooks** - Create reusable logic in dedicated hooks directory
- **Type definitions** - Maintain shared TypeScript types in centralized location
- **Asset organization** - Structure images, icons, and fonts in logical public subdirectories
- **Style management** - Keep global styles minimal, prefer component-scoped styling
- **Test co-location** - Place test files adjacent to components they test
- **Storybook stories** - Co-locate stories with components for easier maintenance
- **Documentation** - Include README files for complex component systems and utilities

## Common Errors to Avoid

### CSS Import Order Issues
- **@import statements must come BEFORE @tailwind directives** in CSS files
- CSS imports must be at the top, followed by Tailwind base, components, then utilities
- Incorrect order causes compilation failures and missing styles
- Use CSS custom properties for dynamic theming instead of complex import chains

### JSX Syntax Errors
- **Broken motion component tags** - Framer Motion components require proper opening and closing tags
- Check for unclosed or malformed animated components in complex layouts
- Validate JSX structure when combining motion components with conditional rendering
- Use TypeScript strict mode to catch malformed component structures early

### Missing Error Boundaries
- **Always implement error boundaries for production applications**
- Create reusable ErrorBoundary components that gracefully handle component failures
- Implement fallback UIs that maintain user context and provide recovery options
- Test error boundary behavior with intentionally broken components during development
- Use error boundaries at route level and around complex component trees

## Best Practices Summary

### Do's ✅
- Start with mobile design and enhance for desktop
- Use semantic HTML elements
- Implement proper ARIA labels and roles
- Test with keyboard navigation
- Optimize images and fonts
- Use TypeScript strictly
- Validate all user inputs with Zod
- Write tests for critical user flows
- Use Storybook for component development
- Follow consistent naming conventions

### Don'ts ❌
- Don't rely on hover states for mobile
- Don't use small touch targets (< 44px)
- Don't ignore accessibility requirements
- Don't skip form validation
- Don't use any types in TypeScript
- Don't inline critical CSS
- Don't forget loading and error states
- Don't skip responsive testing
- Don't ignore Core Web Vitals
- Don't use deprecated React patterns

## Resources
- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Radix UI Documentation](https://www.radix-ui.com/)
- [Shadcn/UI Documentation](https://ui.shadcn.com/)
- [React Hook Form Documentation](https://react-hook-form.com/)
- [Zod Documentation](https://zod.dev/)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)