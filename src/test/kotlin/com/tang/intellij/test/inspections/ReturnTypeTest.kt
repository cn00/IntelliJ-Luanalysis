/*
 * Copyright (c) 2017. tangzx(love.tangzx@qq.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.tang.intellij.test.inspections

import com.tang.intellij.lua.codeInsight.inspection.ReturnTypeInspection

class ReturnTypeTest : LuaInspectionsTestBase(ReturnTypeInspection()) {

    fun `test return type mismatch`() = checkByText("""
        ---@return string
        local function test()
            return <error descr="Type mismatch. Required: 'string' Found: '1'">1</error>
        end
    """)

    fun `test matching return type`() = checkByText("""
        ---@return string
        local function test()
            return "right"
        end
    """)

    fun `test non return`() = checkByText("""
        ---@return string
        local function test<error descr="Return type 'string' specified but no return values found.">()
        end</error>
    """)

    fun `test implicit return void`() = checkByText("""
        ---@return void
        local function test()
        end
    """)

    fun `test explicit return void`() = checkByText("""
        ---@return void
        local function test()
            return
        end
    """)
}
