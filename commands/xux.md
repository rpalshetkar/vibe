# xux - UI/UX Design & Implementation

## Purpose
Design and implement user interfaces following modern UX principles and the comprehensive UI development standards defined in `@devrules/uirules.md`.

## When to Use
- Creating new UI components or pages
- Redesigning existing interfaces
- Implementing responsive designs
- Building accessible user experiences
- Optimizing mobile-first experiences
- Setting up component libraries

## Technology Stack Reference
Follow the stack defined in `@devrules/uirules.md`:
- **Framework**: Next.js 14+ (App Router)
- **Styling**: Tailwind CSS + Shadcn/UI
- **Validation**: Zod + React Hook Form
- **Animation**: Framer Motion
- **Icons**: Lucide React
- **Testing**: Vitest + Testing Library

## Process

### 1. UX Research & Planning
- **User Story Analysis**: Understand user needs and pain points
- **Mobile-First Strategy**: Design for smallest screen first
- **Accessibility Requirements**: Plan for WCAG 2.1 AA compliance
- **Performance Considerations**: Target Core Web Vitals metrics

### 2. Design System Application
Apply design tokens from `@devrules/uirules.md`:
```typescript
// Spacing (4px grid system)
const spacing = { xs: '4px', sm: '8px', md: '16px', lg: '24px', xl: '32px' }

// Breakpoints (mobile-first)
const breakpoints = { sm: '640px', md: '768px', lg: '1024px', xl: '1280px' }

// Typography scale
const typography = { xs: '12px', sm: '14px', base: '16px', lg: '18px', xl: '20px' }
```

### 3. Component Architecture
Choose appropriate component category:
- **Layout**: Container, Grid, Flex, Stack
- **Navigation**: BottomNav, Drawer, Breadcrumb
- **Input**: Form fields, Search, Filters
- **Data Display**: Cards, Lists, Tables
- **Feedback**: Toast, Dialog, Loading
- **Media**: Image, Video, Gallery

### 4. Implementation Standards

#### Component Structure
```typescript
// Follow this pattern for all components
interface ComponentProps {
  variant?: 'primary' | 'secondary'
  size?: 'sm' | 'md' | 'lg'
  disabled?: boolean
  className?: string
  children?: React.ReactNode
}

function Component({
  variant = 'primary',
  size = 'md',
  disabled = false,
  className,
  children
}: ComponentProps) {
  // Implementation following uirules.md standards
}
```

#### Mobile-First Responsive Design
```typescript
// Always start with mobile, enhance for larger screens
<div className="
  // Mobile (default)
  p-4 text-sm flex flex-col
  // Tablet and up
  md:p-6 md:text-base md:flex-row
  // Desktop and up
  lg:p-8 lg:text-lg
">
  {content}
</div>
```

#### Form Implementation with Zod
```typescript
import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'

const schema = z.object({
  // Define validation schema
})

type FormData = z.infer<typeof schema>

function Form() {
  const form = useForm<FormData>({
    resolver: zodResolver(schema)
  })
  // Implementation
}
```

### 5. Accessibility Implementation
Ensure WCAG 2.1 AA compliance:
- **Focus Management**: Visible focus indicators
- **Keyboard Navigation**: Full keyboard support
- **Screen Readers**: Proper ARIA labels
- **Color Contrast**: 4.5:1 minimum ratio
- **Touch Targets**: 44px minimum size

```typescript
// Accessible component example
<Button
  aria-label="Save document"
  aria-describedby="save-help"
  disabled={isSaving}
  className="min-h-[44px] min-w-[44px]" // Touch-friendly
>
  <SaveIcon className="h-5 w-5" />
  <span className="sr-only">Save</span>
</Button>
```

### 6. Performance Optimization
Target Core Web Vitals:
- **LCP < 2.5s**: Optimize images and fonts
- **FID < 100ms**: Minimize JavaScript blocking
- **CLS < 0.1**: Reserve space for dynamic content

```typescript
// Performance optimizations
import Image from 'next/image'
import { lazy, Suspense } from 'react'

// Optimized images
<Image
  src="/hero.jpg"
  alt="Description"
  width={800}
  height={600}
  priority // Above the fold
  placeholder="blur"
/>

// Lazy load heavy components
const HeavyComponent = lazy(() => import('./HeavyComponent'))

<Suspense fallback={<Skeleton />}>
  <HeavyComponent />
</Suspense>
```

### 7. Testing & Validation
```typescript
// Component testing
import { render, screen, userEvent } from '@testing-library/react'

describe('Component', () => {
  it('meets accessibility requirements', () => {
    render(<Component />)
    expect(screen.getByRole('button')).toBeInTheDocument()
    expect(screen.getByLabelText('Action')).toBeInTheDocument()
  })

  it('works on mobile viewports', () => {
    render(<Component />)
    // Test mobile-specific behavior
  })
})
```

## Workflow Steps

### Step 1: Analyze Requirements
```markdown
## UX Analysis
- **User Story**: As a [user], I want [goal] so that [benefit]
- **Device Priority**: Mobile → Tablet → Desktop
- **Accessibility Needs**: [screen readers, keyboard, etc.]
- **Performance Requirements**: [loading time, animations, etc.]
```

### Step 2: Design System Selection
- Choose components from established categories
- Apply consistent spacing and typography
- Use approved color palette and design tokens
- Plan responsive behavior across breakpoints

### Step 3: Implementation
- Start with mobile layout
- Implement accessibility features
- Add form validation with Zod
- Apply animations with Framer Motion
- Optimize for performance

### Step 4: Testing & Validation
- Test responsive design on all breakpoints
- Validate accessibility with screen readers
- Check keyboard navigation
- Measure Core Web Vitals
- Write component tests

## Common Patterns

### Modal/Dialog Pattern
```typescript
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'

function Modal({ open, onClose, title, children }) {
  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
        </DialogHeader>
        {children}
      </DialogContent>
    </Dialog>
  )
}
```

### Form Pattern
```typescript
function UserForm() {
  const schema = z.object({
    email: z.string().email(),
    name: z.string().min(2)
  })

  const form = useForm({
    resolver: zodResolver(schema)
  })

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input placeholder="Enter email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit" className="w-full sm:w-auto">
          Submit
        </Button>
      </form>
    </Form>
  )
}
```

### Navigation Pattern
```typescript
function Navigation() {
  return (
    <>
      {/* Mobile: Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-background border-t md:hidden">
        <div className="flex justify-around py-2">
          {navItems.map(item => (
            <NavItem key={item.href} {...item} />
          ))}
        </div>
      </nav>

      {/* Desktop: Top Navigation */}
      <nav className="hidden md:flex items-center space-x-6">
        {navItems.map(item => (
          <NavLink key={item.href} {...item} />
        ))}
      </nav>
    </>
  )
}
```

## Quality Checklist

Before considering UX implementation complete, verify:

### ✅ Design Standards
- [ ] Mobile-first responsive design implemented
- [ ] 4px grid spacing system used consistently
- [ ] Typography scale followed
- [ ] Component variants properly defined
- [ ] Design tokens applied correctly

### ✅ Accessibility
- [ ] WCAG 2.1 AA compliance verified
- [ ] Keyboard navigation works completely
- [ ] Screen reader compatibility tested
- [ ] Color contrast meets 4.5:1 ratio
- [ ] Touch targets minimum 44px

### ✅ Performance
- [ ] Core Web Vitals targets met
- [ ] Images optimized with Next.js Image
- [ ] Animations use CSS transforms
- [ ] Bundle size impact minimized
- [ ] Loading states implemented

### ✅ Code Quality
- [ ] TypeScript strict mode compliance
- [ ] Zod validation for all forms
- [ ] Component tests written
- [ ] Storybook stories created
- [ ] Error boundaries implemented

### ✅ Cross-Device Testing
- [ ] iPhone/Android mobile testing
- [ ] Tablet landscape/portrait testing
- [ ] Desktop browser testing
- [ ] Touch and mouse interaction testing
- [ ] Different screen densities tested

## Integration with Other Commands

### Related Workflows
- Use `/xprd` to define UI/UX requirements in PRDs
- Use `/xspec` to extract UI components from requirements
- Use `/xtasks` to break down UX implementation into tasks
- Use `/xgo` to implement UX tasks systematically

### File Organization
```
project/
├── src/
│   ├── components/
│   │   ├── ui/           # Base Shadcn components
│   │   ├── layout/       # Layout components
│   │   ├── forms/        # Form components
│   │   └── navigation/   # Navigation components
│   ├── lib/
│   │   ├── utils.ts      # Utility functions
│   │   └── validations.ts # Zod schemas
│   └── styles/
│       └── globals.css   # Global styles
└── docs/
    └── ux/
        ├── design-system.md
        ├── component-specs.md
        └── accessibility-audit.md
```

## Resources & References
- **UI Rules**: `@devrules/uirules.md` - Complete UI development standards
- **Next.js**: https://nextjs.org/docs
- **Tailwind CSS**: https://tailwindcss.com/docs
- **Shadcn/UI**: https://ui.shadcn.com/
- **Accessibility**: https://www.w3.org/WAI/WCAG21/quickref/
- **Core Web Vitals**: https://web.dev/vitals/

## Example Usage

```bash
# Start UX design process
/xux "Create a user dashboard with mobile-first design"

# Follow the workflow:
# 1. Analyze user needs and mobile requirements
# 2. Choose appropriate components (Cards, Navigation, etc.)
# 3. Implement with Tailwind + Shadcn/UI
# 4. Add Zod validation for forms
# 5. Test accessibility and performance
# 6. Verify against quality checklist
```

Remember: **Always reference `@devrules/uirules.md` for complete technical specifications and implementation details.**