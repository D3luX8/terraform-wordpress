output "rds_output" {

  value = {
    db = aws_db_instance.db_wp-tf.id

  }

}