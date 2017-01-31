-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System;
local CSharpLuaLuaAst;
System.usingDeclare(function (global) 
    CSharpLuaLuaAst = CSharpLua.LuaAst;
end);
System.namespace("CSharpLua.LuaAst", function (namespace) 
    namespace.class("LuaMemberAccessExpressionSyntax", function (namespace) 
        local getIsObjectColon, Render, __ctor__;
        getIsObjectColon = function (this) 
            return this.OperatorToken == ":" --[[Tokens.ObjectColon]];
        end;
        Render = function (this, renderer) 
            renderer:Render3(this);
        end;
        __ctor__ = function (this, expression, name, isObjectColon) 
            if isObjectColon == nil then isObjectColon = false end
            if expression == nil then
                System.throw(System.ArgumentNullException("expression"));
            end
            if name == nil then
                System.throw(System.ArgumentNullException("name"));
            end
            this.Expression = expression;
            this.Name = name;
            this.OperatorToken = isObjectColon and ":" --[[Tokens.ObjectColon]] or "." --[[Tokens.Dot]];
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaExpressionSyntax
            }, 
            getIsObjectColon = getIsObjectColon, 
            Render = Render, 
            __ctor__ = __ctor__
        };
    end);
    namespace.class("LuaPropertyAdapterExpressionSyntax", function (namespace) 
        local Update, setIsGetOrAdd, getIsProperty, GetCloneOfGet, Render, __ctor1__, __ctor2__;
        Update = function (this, memberAccessExpression) 
            local invocationExpression = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, memberAccessExpression);
            invocationExpression.ArgumentList.Arguments:AddRange1(this.InvocationExpression.ArgumentList.Arguments);
            this.InvocationExpression = invocationExpression;
        end;
        setIsGetOrAdd = function (this, value) 
            this.identifier_.IsGetOrAdd = value;
        end;
        getIsProperty = function (this) 
            return this.identifier_.IsProperty;
        end;
        GetCloneOfGet = function (this) 
            setIsGetOrAdd(this, false);
            this.isAutoGet_ = true;
            local invocationExpression = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, this.InvocationExpression.Expression);
            invocationExpression.ArgumentList.Arguments:AddRange1(this.InvocationExpression.ArgumentList.Arguments);
            return invocationExpression;
        end;
        Render = function (this, renderer) 
            this.InvocationExpression.Expression:Render(renderer);
            if this.isAutoGet_ then
                setIsGetOrAdd(this, true);
            end
            this.InvocationExpression.ArgumentList:Render(renderer);
        end;
        __ctor1__ = function (this, identifier) 
            this.identifier_ = identifier;
            this.InvocationExpression = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, identifier);
        end;
        __ctor2__ = function (this, memberAccess, identifier) 
            this.identifier_ = identifier;
            this.InvocationExpression = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, memberAccess);
        end;
        return {
            __inherits__ = {
                CSharpLuaLuaAst.LuaExpressionSyntax
            }, 
            Update = Update, 
            setIsGetOrAdd = setIsGetOrAdd, 
            getIsProperty = getIsProperty, 
            isAutoGet_ = False, 
            GetCloneOfGet = GetCloneOfGet, 
            Render = Render, 
            __ctor__ = {
                __ctor1__, 
                __ctor2__
            }
        };
    end);
end);
