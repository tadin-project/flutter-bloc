-- CreateTable
CREATE TABLE `ms_users` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(255) NULL,
    `user_email` VARCHAR(255) NOT NULL,
    `user_password` TEXT NOT NULL,
    `role_id` SMALLINT UNSIGNED NOT NULL DEFAULT 3,
    `verified_status` BOOLEAN NOT NULL DEFAULT false,
    `verified_at` DATETIME(3) NULL,
    `uuid` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `ms_users_user_email_key`(`user_email`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ms_roles` (
    `role_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `role_kode` VARCHAR(10) NOT NULL,
    `role_name` VARCHAR(255) NULL,
    `role_status` BOOLEAN NULL DEFAULT true,

    UNIQUE INDEX `ms_roles_role_kode_key`(`role_kode`),
    PRIMARY KEY (`role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ms_users` ADD CONSTRAINT `ms_users_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `ms_roles`(`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;
