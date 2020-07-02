//
//  AppDrLabTests.swift
//  AppDrLabTests
//
//  Created by Han Luong on 6/6/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import XCTest
@testable import AppDrLab

class AppDrLabTests: XCTestCase {

    private var loginViewModel: LoginViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginInValidUser() throws {
        loginViewModel = LoginViewModel(email: "invalid_user@gmail.com", password: "12122012gv!", token: "2", os: "I")
        let exp = self.expectation(description: "Test Passed")
        var user: User?
        WebService().load(resource: User.login(vm: loginViewModel)) { result in
            user = try? result.get()
            exp.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(user)
        }
    }
    
    func testLoginValidUser() throws {
        loginViewModel = LoginViewModel(email: "ttt@gmail.com", password: "12122012gv!", token: "2", os: "I")
        let exp = self.expectation(description: "Test Passed")
        var user: User?
        WebService().load(resource: User.login(vm: loginViewModel)) { result in
            user = try? result.get()
            exp.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNotNil(user)
        }
    }
    
    func testLoginValidUserButExpectedTestFailed() throws {
        loginViewModel = LoginViewModel(email: "ttt@gmail.com", password: "12122012gv!", token: "2", os: "I")
        let exp = self.expectation(description: "Test Failed")
        var user: User?
        WebService().load(resource: User.login(vm: loginViewModel)) { result in
            user = try? result.get()
            exp.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            XCTAssertNil(user)
        }
    }
}
