--Add This to your DataBase for register the vip users
CREATE TABLE vip_users (
    boutiqueId VARCHAR(255) NOT NULL,
    isvip BOOLEAN DEFAULT FALSE NOT NULL,
    PRIMARY KEY (boutiqueId)
);

ALTER TABLE `users`
ADD COLUMN boutiqueId INT(11);