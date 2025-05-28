# btick2

A comprehensive Q/KDB+ library collection providing a modular framework for building behavior-driven applications in KDB+.

## Overview

btick2 is a framework that combines a powerful behavior tag (bt) execution system with over 25 specialized utility libraries. It emphasizes modularity, testability, and behavior-driven design patterns for KDB+ development.

## Core Architecture

### Behavior Tag (bt) System
The core behavior-driven execution framework (`qlib/bt/bt.q`) provides:
- Event-driven triggers and actions
- Timer scheduling and execution  
- Error handling and tracing
- Function argument injection and execution context

### Module System
Dynamic module management (`qlib/import/import.q`) with:
- Dependency-aware module loading
- Repository-based organization
- JSON configuration management

### Testing Framework
Comprehensive test suite system (`qlib/qtx/qtx.q`) featuring:
- Parameter injection for test data
- Multiple assertion types (shouldTrue, shouldEq, shouldFail, shouldData)
- Before/after hooks and nested test cases
- Test execution tracking and reporting

## Quick Start

### Installation
Set the `btick2` environment variable to point to your installation:
```bash
export btick2=/path/to/btick2/src
```

### Basic Usage
```q
// Load the main library
\l getenv[`btick2],"/qlib.q"

.import.summary[] / this will show all avaialbe libraries

// Load specific modules
.import.module`datetime
.import.module`json
```

## Available Libraries

### Core Utilities
- **datetime** - Date/time manipulation functions
- **util** - Table manipulation and data processing utilities
- **json** - JSON parsing and manipulation
- **os** - Operating system integration

### Integration Libraries
- **rlang** - R language integration
- **xml** - XML parsing and processing

### Specialized Tools
- **dbmaint** - Database maintenance and management
- **proto** - Domain Specific Embedded Language 
- **tp** - Tick plant utilities
- **remote** - Remote procedure calls
- **hopen** - Enhanced handle management

### Development Tools
- **qtx** - Testing framework and test utilities
- **doc** - Documentation generation
- **repository** - Project template and scaffolding

## Project Structure

```
src/
├── qlib.q              # Main library loader
├── qtx.q               # Test runner entry point  
├── qlib/               # Library modules
│   ├── bt/             # Behavior tag core system
│   ├── import/         # Module system
│   ├── qtx/            # Testing framework
│   ├── datetime/       # Date/time utilities
│   ├── json/           # JSON processing
│   └── [other libs]/   # Additional libraries
└── excel/              # Excel integration examples
```

Each library follows a consistent structure:
- `qlib/{lib}/{lib}.q` - Main library file
- `qlib/{lib}/test/001.q` - Test suite

## Development

### Creating New Libraries
Use the repository template system:
```q
.import.module`repository
.repository.create[`mylib;`lib]  // Create new library
```

## Configuration

Configuration files use JSON format in home directories. The default configuration supports:
- Module loading paths
- Library-specific settings

## Platform Support

- **Linux**: Full support with native libraries
- **Windows**: Full support with Windows-specific binaries
- **Cross-platform**: Most utilities work across platforms
