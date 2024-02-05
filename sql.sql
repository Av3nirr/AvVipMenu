--Add This to your DataBase for register the vip users
CREATE TABLE vip_users (
    identifier VARCHAR(255) NOT NULL,
    isvip BOOLEAN DEFAULT FALSE NOT NULL,
    PRIMARY KEY (identifier)
);

ALTER TABLE `users`
ADD COLUMN boutiqueId INT(11);