# start project
npm init --yes

# add library - install express framework
npm install express

# templates engine
npm install ejs

# mysql
npm install mysql 
npm install express-myconnection

# nodemon
npm install nodemon -D

# package.json
# "scripts": {
#     "start": "npx nodemon src/app.js",
#     "test": "echo \"Error: no test specified\" && exit 1"
# },
npm start

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install mariadb-server mariadb-client
sudo mysql_secure_installation
sudo mysql -u root -p
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'toor';
GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'localhost' WITH GRANT OPTION;
sudo apt-get install apache2
sudo apt-get install php
sudo apt-get install phpmyadmin

CREATE DATABASE IF NOT EXISTS `appuser`;GRANT ALL PRIVILEGES ON `appuser`.* TO 'appuser'@'%';GRANT ALL PRIVILEGES ON `appuser\_%`.* TO 'appuser'@'%';

const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM test', (err, rows) => {
            if (err) {
                res.json(err);
            }

            //console.log(rows);
            res.render('index', {
                data: rows
            });
        });
    });
};

controller.save = (req, res) => {
    //console.log(req.body);
    //res.send('llegó');
    const data = req.body;
    req.getConnection((err, conn) => {        
        conn.query('INSERT INTO test set ?', [data], (err, rows) => {
            console.log(rows);
            if (err) {
                res.json(err);
            }
            res.redirect('/');
        });
    });
};

controller.edit = (req, res) => {
    const { id } = req.params;
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM test WHERE id = ?', [id], (err, rows) => {
            if (err) {
                res.json(err);
            }

            //console.log(rows);
            res.render('edit', {
                data: rows[0]
            });
        });
    });
};


controller.update = (req, res) => {
    const { id } = req.params;
    const info = req.body;
    req.getConnection((err, conn) => {
        conn.query('UPDATE test set ? WHERE id = ?', [info, id], (err, rows) => {
            if (err) {
                res.json(err);
            }

            res.redirect('/');
        });
    });
};


controller.delete = (req, res) => {
    //console.log(req.params.id);
    //res.send('llegó');
    const { id } = req.params;
    req.getConnection((err, conn) => {        
        conn.query('DELETE FROM test WHERE id = ?', [id], (err, rows) => {
            console.log(rows);
            if (err) {
                res.json(err);
            }
            res.redirect('/');
        });
    });
};

module.exports = controller;