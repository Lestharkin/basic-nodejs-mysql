/* jshint esversion: 6 */
/* jshint browser: true */

const { render } = require('ejs');
const express = require('express');

const controller = {};

controller.index = (req, res) => {
    const config = {
        nav: "index",
        navContent: {
            title: "HTML 5: Home",
            link_1: {
                href: "/register",
                text: "Register"
            },
            link_2: {
                href: "/login",
                text: "Login"
            }
        }
    };    
    res.render('index.ejs', { data: config });
};

controller.register = (req, res) => {
    // console.log(req.body);
    // const { id } = req.body;
    // console.log(id);
    // res.send(`regiter: ${id}`);
    const config = {
        nav: "register",
        navContent: {
            title: "HTML 5: Register",
            link_1: {
                href: "/index",
                text: "Home"
            },
            link_2: {
                href: "/login",
                text: "Login"
            }
        }
    };  
    res.render('register.ejs', { data: config });
};

controller.login = (req, res) => {
    const config = {
        nav: "register",
        navContent: {
            title: "HTML 5: Register",
            link_1: {
                href: "/index",
                text: "Home"
            },
            link_2: {
                href: "/register",
                text: "Register"
            },
        }
    }; 
    res.render("login.ejs", { data: config });
};

controller.registerSelect = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM user', (err, rows) => {
            if (err) {
                res.send(err);
            }

            const config = {
                nav: "registerlist",
                navContent: {
                    title: "HTML 5: List",
                    link_1: {
                        href: "/index",
                        text: "Home"
                    },
                    link_2: {
                        href: "/login",
                        text: "Login"
                    }
                },
                database: rows
            }; 
            res.render('registerlist', { data: config });
        });
    });
};

controller.registerInsert = (req, res) => {
    const data = req.body;
    req.getConnection((err, conn) => {        
        conn.query('INSERT INTO user SET ?', [data], (err, rows) => {
            console.log(rows);
            if (err) {
                res.send(err);
            }
            res.send(data);
        });
    });    
};

module.exports = controller;