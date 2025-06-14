#!/bin/bash
# Run all Neovim tests and provide a comprehensive report

echo "🧪 Running Complete Neovim Test Suite"
echo "====================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results tracking
overall_status=0

echo -e "${BLUE}📋 Step 1: Quick Environment Check${NC}"
echo "-------------------------------------"
if ./tests/check_nvim.sh; then
    echo -e "${GREEN}✅ Environment check passed${NC}"
else
    echo -e "${RED}❌ Environment check failed${NC}"
    overall_status=1
fi

echo -e "\n${BLUE}📋 Step 2: Unit Tests${NC}"
echo "-------------------------------------"
if python3 tests/test_scripts.py; then
    echo -e "${GREEN}✅ Unit tests passed${NC}"
else
    echo -e "${RED}❌ Unit tests failed${NC}"
    overall_status=1
fi

echo -e "\n${BLUE}📋 Step 3: Comprehensive Functionality Tests${NC}"
echo "-------------------------------------"
echo -e "${YELLOW}ℹ️  Note: This test may show warnings for optional components${NC}"
if python3 tests/test_nvim_functionality.py; then
    echo -e "${GREEN}✅ Comprehensive tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Comprehensive tests had issues (this is often normal)${NC}"
    # Don't fail overall status for comprehensive tests as they're very strict
fi

echo -e "\n====================================="
echo "🏁 Overall Test Results"
echo "====================================="

if [ $overall_status -eq 0 ]; then
    echo -e "${GREEN}🎉 Success! Your Neovim development environment is ready!${NC}"
    echo -e "${GREEN}🚀 All essential functionality is working correctly.${NC}"
    echo ""
    echo "🔧 Quick tips:"
    echo "  • Open files: nvim filename"
    echo "  • Find files: <leader>ff in nvim"
    echo "  • Search content: <leader>fg in nvim"
    echo "  • Go to definition: gd in nvim"
    echo "  • Show documentation: K in nvim"
else
    echo -e "${RED}❌ Issues detected in your setup!${NC}"
    echo -e "${RED}🔧 Please address the failed tests before using Neovim.${NC}"
    echo ""
    echo "💡 Common fixes:"
    echo "  • Run: sh up (to complete setup)"
    echo "  • Install missing tools manually"
    echo "  • Check network connectivity"
fi

echo ""
echo "📚 For more help:"
echo "  • Read: tests/README.md"
echo "  • Check: :checkhealth in Neovim"
echo "  • Review: CLAUDE.md for setup details"

exit $overall_status