-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System;
local CSharpLuaLuaAst;
System.usingDeclare(function (global) 
    CSharpLuaLuaAst = CSharpLua.LuaAst;
end);
System.namespace("CSharpLua.LuaAst", function (namespace) 
    namespace.class("LuaArgumentSyntax", function (namespace) 
        local Render, __ctor__;
        Render = function (this, renderer) 
            renderer:Render8(this);
        end;
        __ctor__ = function (this, expression) 
            if expression == nil then
                System.throw(System.ArgumentNullException("expression"));
            end
            this.Expression = expression;
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaSyntaxNode
            }, 
            Render = Render, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaArgumentListSyntax", function (namespace) 
        local getOpenParenToken, getCloseParenToken, Render, AddArgument, AddArgument1, __ctor__;
        getOpenParenToken = function (this) 
            return "(" --[[Tokens.OpenParentheses]];
        end;
        getCloseParenToken = function (this) 
            return ")" --[[Tokens.CloseParentheses]];
        end;
        Render = function (this, renderer) 
            renderer:Render7(this);
        end;
        AddArgument = function (this, argument) 
            this.Arguments:Add1(argument);
        end;
        AddArgument1 = function (this, argument) 
            AddArgument(this, CSharpLuaLuaAst.LuaArgumentSyntax(argument));
        end;
        __ctor__ = function (this) 
            this.Arguments = CSharpLuaLuaAst.LuaSyntaxList_1(CSharpLuaLuaAst.LuaArgumentSyntax)();
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaSyntaxNode
            }, 
            getOpenParenToken = getOpenParenToken, 
            getCloseParenToken = getCloseParenToken, 
            Render = Render, 
            AddArgument = AddArgument, 
            AddArgument1 = AddArgument1, 
            __ctor__ = __ctor__
        };
    end);
end);
